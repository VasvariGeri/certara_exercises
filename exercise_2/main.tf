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
