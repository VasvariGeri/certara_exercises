# Exercise 2: S3 Backup Bucket

This exercise contains Terraform code for an S3 bucket intended to store filesystem backups from another AWS account.

## Planned Scope

- Create a private S3 bucket for backup objects.
- Retain backups for 180 days and no longer.
- Apply security-focused S3 defaults.
- Apply cost-conscious lifecycle rules.
- Allow this IAM role to upload backup files:

```text
arn:aws:iam::123456789012:role/backup_uploader
```

## Planned Validation

The configuration will be validated locally with Terraform:

```sh
terraform fmt -recursive -check exercise_2
terraform -chdir=exercise_2 init -backend=false -input=false
terraform -chdir=exercise_2 validate
```

## Cost Note

Do not run `terraform apply` against a real AWS account unless you intentionally want to create resources.
