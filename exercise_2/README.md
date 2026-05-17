# Exercise 2: S3 Backup Bucket

This exercise contains Terraform code for an S3 bucket intended to store filesystem backups from another AWS account.

## What It Builds

- Create a private S3 bucket for backup objects.
- Retain backups for 180 days and no longer.
- Apply security-focused S3 defaults.
- Apply cost-conscious lifecycle rules.
- Allow this IAM role to upload backup files:

```text
arn:aws:iam::123456789012:role/backup_uploader
```

## Security And Retention

- Public access is blocked at bucket level.
- Object ownership is enforced by the bucket owner.
- Bucket versioning is enabled.
- Default server-side encryption uses a customer managed KMS key with rotation enabled.
- S3 bucket keys are enabled to reduce KMS request cost.
- Lifecycle rules expire current and noncurrent object versions after 180 days.
- Incomplete multipart uploads are cleaned up after 7 days.
- Bucket policy denies insecure HTTP access.
- The uploader role is allowed to upload backup objects.
- The uploader role is allowed to use the KMS key for encryption.

## Validate Without an AWS Account

The configuration can be checked locally without an AWS account:

```sh
make validate-exercise-2
```

This runs Terraform formatting checks, initializes without a backend, and validates the configuration. An internet connection is still required the first time Terraform downloads the AWS provider.

You can also run the commands manually:

```sh
terraform fmt -recursive -check exercise_2
terraform -chdir=exercise_2 init -backend=false -input=false
terraform -chdir=exercise_2 validate
```

## Plan

The root module includes mock defaults so a plan can be generated locally:

```sh
make plan-exercise-2
```

The default bucket name and account ID are examples for planning only. Override them before deploying to a real AWS account.

## Cost Note

Do not run `terraform apply` against a real AWS account unless you intentionally want to create resources. S3 storage, KMS key usage, and API requests can incur costs.
