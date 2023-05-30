terraform{
    required_version = ">= 1.0"
    backend "local" {}
    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = var.region
    shared_credentials_files = ["$HOME/.aws/credentials"]
    profile                 = "default"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc_epam"
  cidr = "192.168.0.0/16"

  azs             = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  private_subnets = ["192.168.1.0/24"]
  public_subnets  = ["192.168.10.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "epam"
  }
}