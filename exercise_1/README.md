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

## Validate

From the example directory:

```sh
cd exercise_1/examples/basic
terraform init
terraform plan
```

The example uses mock AWS credentials and disables provider-side credential validation so the configuration can be reviewed without deploying resources.

## Cost Note

The module creates a NAT gateway, which is not free tier eligible. Do not apply this configuration unless you intentionally want to create billable AWS resources.
