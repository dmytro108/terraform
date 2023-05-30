terraform{
    required_version = ">= 1.0"
    backend "local" {}
    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
    region = var.region
    shared_credentials_file = "$HOME/.aws/credentials"
    profile                 = "default"
}

resource "aws_vpc" "main" {
    cidr_block       = var.vpc_cidr
    instance_tenancy = "default"

    tags = {
        Name = var.vpc_name
    }
}