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
resource "aws_instance" "web_cluster" {
    count                  = var.serv_num
    server_name            = "web_server-${count.index}"
    ami                    = var.ec2_ami_id
    instance_type          = var.ec2_type
    subnet_id              = module.vpc.private_subnets[0]
    vpc_security_group_ids = [ aws_security_group.web_cluster_access.id ]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello World from ${aws_instance.web_cluster[count.index].server_name}
                nohup busybox httpd -f -p ${var.port_to} &
                EOF

    tags = {
        "Name"        = "${aws_instance.web_cluster[count.index].server_name}"
        "Terraform"   = "true"
        "Environment" = var.env_name
   }
}

//Create Security group for web servers
resource "aws_security_group" "web_cluster_access" {
    vpc_id = module.vpc.vpc_id
    
    ingress { 
        from_port = var.port_from
        to_port = var.port_to
        protocol = "tcp"
    }
    
    egress {
        from_port = var.port_from
        to_port = var.port_to
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        "Name"        = "web"
        "Terraform"   = "true"
        "Environment" = var.env_name
  }   
}

//Create application load balancer
resource "aws_lb" "web_balancer" {
    load_balancer_type = "application"
    subnets = module.vpc.public_subnets
}