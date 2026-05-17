output "bucket_id" {
  description = "Name of the backup bucket."
  value       = aws_s3_bucket.backups.id
}

output "bucket_arn" {
  description = "ARN of the backup bucket."
  value       = aws_s3_bucket.backups.arn
}
