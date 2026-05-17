variable "aws_region" {
  description = "AWS region used by this exercise."
  type        = string
  default     = "eu-central-1"
}

variable "bucket_name" {
  description = "Globally unique name for the backup bucket."
  type        = string
}

variable "backup_uploader_role_arn" {
  description = "IAM role ARN allowed to upload backup objects."
  type        = string
  default     = "arn:aws:iam::123456789012:role/backup_uploader"
}

variable "retention_days" {
  description = "Number of days backup objects are retained."
  type        = number
  default     = 180

  validation {
    condition     = var.retention_days == 180
    error_message = "The backup policy requires retention to be exactly 180 days."
  }
}

variable "tags" {
  description = "Additional tags to apply to supported resources."
  type        = map(string)
  default     = {}
}
