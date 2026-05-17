# Exercise 1: VPC Terraform Module

This exercise contains a reusable Terraform module that creates a VPC suitable for a basic public/private application layout.

## What It Builds

- One VPC with DNS support enabled.
- Two public subnets across two availability zones.
- Two private subnets across the same two availability zones.
- An internet gateway for direct internet access from public subnets.
- A NAT gateway for outbound internet access from private subnets.
- A gateway VPC endpoint for S3, attached to all route tables, so S3 API traffic stays on the AWS backbone network.

## Layout

```text
.
├── modules/
│   └── vpc/
└── examples/
    └── basic/
```

## Validate Without an AWS Account

The configuration can be checked locally without an AWS account:

```sh
make validate-exercise-1
```

This runs Terraform formatting checks, initializes the example without a backend, and validates the configuration. An internet connection is still required the first time Terraform downloads the AWS provider.

You can also run the commands manually:

```sh
terraform fmt -recursive -check exercise_1
terraform -chdir=exercise_1/examples/basic init -backend=false -input=false
terraform -chdir=exercise_1/examples/basic validate
```

## Plan

From the example directory:

```sh
cd exercise_1/examples/basic
terraform init
terraform plan
```

The example uses mock AWS credentials and disables some provider-side credential validation, but a real `terraform plan` may still require AWS provider API access depending on provider behavior. Do not run `terraform apply` for this exercise unless you intentionally want to create billable AWS resources.

## Cost Note

The module creates a NAT gateway, which is not free tier eligible. Do not apply this configuration unless you intentionally want to create billable AWS resources.
