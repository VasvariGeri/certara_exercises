# Certara Exercises

This repository contains solutions for three cloud/devops exercises:

- Terraform infrastructure for a VPC module with public/private subnets and S3 private connectivity.
- Terraform infrastructure for an S3 backup bucket with security, retention, and cost controls.
- Kubernetes manifests and local automation for running a simple Go REST service on minikube.


## Exercise 1: VPC Terraform Module

Goal:

- Deploy a VPC with internet access.
- Create four subnets across two availability zones.
- Provide two public subnets for a load balancer or reverse proxy.
- Provide two private subnets for application servers.
- Allow outbound internet access from private subnets.
- Ensure S3 API traffic from the VPC stays on the AWS backbone network.
- Include an example that consumes the module.

Expected validation:

```sh
terraform init
terraform plan
```

## Exercise 2: S3 Backup Bucket

Goal:

- Create an S3 bucket for filesystem backups stored in a separate AWS account.
- Keep backups for 180 days and no longer.
- Apply security and cost-conscious S3 best practices.
- Allow this IAM role to upload backup files:

```text
arn:aws:iam::123456789012:role/backup_uploader
```

Expected validation:

```sh
terraform init
terraform plan
```

## Exercise 3: Minikube REST Service

Goal:

- Package and deploy the provided Go REST service to minikube.
- Expose the `/hello-world` endpoint through a localhost URI.
- Provide Kubernetes manifests that are easy for a developer to understand and modify.
- Add local automation for common workflows where useful.
- Prefer a local image registry over a remote registry.

Expected response:

```json
{
  "message": "Hello World"
}
```
