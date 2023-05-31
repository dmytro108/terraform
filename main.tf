// ********************* Terraform init with latest aws provider
terraform {
    required_version = ">= 1.0"
    backend "local" {}
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

// ********************* AWS provider
provider "aws" {
    region                   = var.region
    shared_credentials_files = [var.credential_path]
    profile                  = var.aws_cli_profile
    
    default_tags {
        tags = {
            "Terraform"   = "true"
            "Environment" = var.env_name
        }
    }
}

// ********************* VPC 
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
  }
}

// ********************* EC2 instances 
resource "aws_instance" "web_cluster" {
    count                  = var.serv_num
    ami                    = var.ec2_ami_id
    instance_type          = var.ec2_type
    subnet_id              = module.vpc.private_subnets[0]
    vpc_security_group_ids = [ aws_security_group.web_cluster_access.id ]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello World from web_server-${count.index}"
                nohup busybox httpd -f -p ${var.port_to} &
                EOF

    tags = {
        "Name"        = "web_server-${count.index}"
   }
}

// ******************** EC2 instances Security Group
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
    }   
}

// ******************* Load Balancer
resource "aws_lb" "web_balancer" {
    load_balancer_type = "application"
    subnets = module.vpc.public_subnets

    tags = {
        "Name" = "web_balancer"
    }
}

// ******************* Load Balanser listener
resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.web_balancer.arn
    port = 80
    protocol = "HTTP"
}

// ******************* Load Balancer Security Group
resource "aws_security_group" "lb_access" {
    vpc_id = module.vpc.vpc_id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = module.vpc.private_subnets_cidr_blocks
    }
}

// ****************** Load Balancer Target Group
resource "aws_lb_target_group" "web_cluster" {
    port = var.port_to
    protocol = "HTTP"
    vpc_id = module.vpc.vpc_id

    health_check {
      path                = "/"
      protocol            = "HTTP"
      matcher             = "200"
      interval            = 10
      timeout             = 5
      healthy_threshold   = 3
      unhealthy_threshold = 10
      pport               =  var.port_to
    }

}