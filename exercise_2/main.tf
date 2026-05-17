locals {
  common_tags = merge(
    var.tags,
    {
      Exercise = "2"
      Purpose  = "filesystem-backups"
    }
  )
}

provider "aws" {
  region = var.aws_region

  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}

resource "aws_s3_bucket" "backups" {
  bucket = var.bucket_name

  tags = merge(local.common_tags, {
    Name = var.bucket_name
  })
}

data "aws_iam_policy_document" "backup_bucket" {
  statement {
    sid    = "DenyInsecureTransport"
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:*"]

    resources = [
      aws_s3_bucket.backups.arn,
      "${aws_s3_bucket.backups.arn}/*",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }

  statement {
    sid    = "AllowBackupUploaderBucketAccess"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.backup_uploader_role_arn]
    }

    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucketMultipartUploads",
    ]

    resources = [aws_s3_bucket.backups.arn]
  }

  statement {
    sid    = "AllowBackupUploaderObjectUploads"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.backup_uploader_role_arn]
    }

    actions = [
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
    ]

    resources = ["${aws_s3_bucket.backups.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "backups" {
  bucket = aws_s3_bucket.backups.id
  policy = data.aws_iam_policy_document.backup_bucket.json
}

resource "aws_s3_bucket_public_access_block" "backups" {
  bucket = aws_s3_bucket.backups.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "backups" {
  bucket = aws_s3_bucket.backups.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "backups" {
  bucket = aws_s3_bucket.backups.id

  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "backup_key" {
  statement {
    sid    = "EnableBucketOwnerKMSAdministration"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.bucket_owner_account_id}:root"]
    }

    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowBackupUploaderKMSUsage"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.backup_uploader_role_arn]
    }

    actions = [
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:GenerateDataKeyWithoutPlaintext",
      "kms:ReEncryptFrom",
      "kms:ReEncryptTo",
    ]

    resources = ["*"]
  }
}

resource "aws_kms_key" "backups" {
  description             = "KMS key for S3 backup bucket encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.backup_key.json

  tags = merge(local.common_tags, {
    Name = "${var.bucket_name}-backup-key"
  })
}

resource "aws_kms_alias" "backups" {
  name          = "alias/${var.bucket_name}-backups"
  target_key_id = aws_kms_key.backups.key_id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backups" {
  bucket = aws_s3_bucket.backups.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.backups.arn
      sse_algorithm     = "aws:kms"
    }

    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "backups" {
  bucket = aws_s3_bucket.backups.id

  rule {
    id     = "expire-backups-after-retention-period"
    status = "Enabled"

    filter {}

    expiration {
      days = var.retention_days
    }

    noncurrent_version_expiration {
      noncurrent_days = var.retention_days
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }

  depends_on = [aws_s3_bucket_versioning.backups]
}
