// Terraform init with latest aws provider
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

//AWS provider, authentification with aws cli file
provider "aws" {
    region = var.region
    shared_credentials_files = ["$HOME/.aws/credentials"]
    profile                 = "default"
}

// Create VPC 
// Two subnets public and private, no NAT
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

//Create 2 EC2 instances in the private subnet
resource "aws_instance" "servers" {
    count = 2
    ami = "ami-0e1c5be2aa956338b" //AWS Linux 2023 x86_64
    instance_type = "t3.micro"
    subnet_id = module.vpc.private_subnets[0]
    tags = {
        "Name" = "server-${count.index}"
    }
}