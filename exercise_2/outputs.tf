output "bucket_id" {
  description = "Name of the backup bucket."
  value       = aws_s3_bucket.backups.id
}

output "bucket_arn" {
  description = "ARN of the backup bucket."
  value       = aws_s3_bucket.backups.arn
}

output "kms_key_arn" {
  description = "ARN of the KMS key used for backup bucket encryption."
  value       = aws_kms_key.backups.arn
}
