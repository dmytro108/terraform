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
    region                   = var.region
    shared_credentials_files = [var.credential_path]
    profile                  = var.aws_cli_profile
}

// Create VPC 
// Two subnets public and private, no NAT
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  cidr            = var.vpc_cidr
  azs             = var.availability_zones
  private_subnets = var.priv_net_cidrs
  public_subnets  = var.pub_net_cidrs

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    "Name"        = var.vpc_name
    "Terraform"   = "true"
    "Environment" = var.env_name
  }
}

//Create 2 EC2 instances in the private subnet
resource "aws_instance" "servers" {
    count         = var.serv_num
    ami           = var.ami_id
    instance_type = var.ec2_type
    subnet_id     = module.vpc.private_subnets[0]

    tags = {
        "Name"        = "server-${count.index}"
        "Terraform"   = "true"
        "Environment" = var.env_name
   }
}