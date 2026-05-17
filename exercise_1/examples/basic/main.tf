provider "aws" {
  region = var.aws_region

  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}

module "vpc" {
  source = "../../modules/vpc"

  name       = "certara-exercise-1"
  aws_region = var.aws_region
  vpc_cidr   = "10.20.0.0/16"

  availability_zones = [
    "eu-central-1a",
    "eu-central-1b",
  ]

  public_subnet_cidrs = [
    "10.20.0.0/24",
    "10.20.1.0/24",
  ]

  private_subnet_cidrs = [
    "10.20.10.0/24",
    "10.20.11.0/24",
  ]

  tags = {
    Project     = "certara-exercises"
    Exercise    = "1"
    Environment = "example"
  }
}
