variable "region"{
    description = "AWS region"
    type = string
    default = "eu-west-2"
}

variable "vpc_name"{
    description = "VPC name tag"
    type = string
    default = "Noname"
}

variable "env_name"{
    description = "Environment tag"
    type = string
    default = "Unknown"
}

variable "vpc_cidr" {
    description = "VPC CIDR"
    type = string
    default = "10.0.0.0/16"  
}

variable "pub_net_cidrs" {
    description = "Public subnet CIDR"
    type = tuple([ string ])
    default = ["10.0.0.0/24"]  
}

variable "priv_net_cidrs" {
    description = "Privat subnet CIDR"
    type = tuple([ string ])
    default = ["10.0.10.0/24"]  
}

variable "credential_path" {
    description = "Path to credential file"
    type = string
    default = "$HOME/.aws/credentials"  
}

variable "aws_cli_profile" {
    description = "Profile name in AWS CLI credential and config file"
    type = string
    default = "default"  
}

variable "ami_id" {
    description = "AWS ami id"
    type = string
    default = "ami-0e1c5be2aa956338b" //AWS Linux 2023 x86_64  
}

variable "ec2_type" {
    description = "AWS instance type"
    type = string
    default = "t3.micro" // Free tier
}

variable "availability_zones" {
    description = "azs"
    type = tuple([ string ])
    default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]  
}

variable "serv_num" {
    description = "Quantity of EC2 instances in privat subnet"
    type = number
    default = 0
  
}
