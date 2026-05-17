output "vpc_id" {
  description = "Created VPC ID."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Created public subnet IDs."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Created private subnet IDs."
  value       = module.vpc.private_subnet_ids
}

output "s3_vpc_endpoint_id" {
  description = "Created S3 gateway VPC endpoint ID."
  value       = module.vpc.s3_vpc_endpoint_id
}
