variable "region"{
    description = "AWS region"
    type = string
    default = "eu-west-2"
}

variable "vpc_name"{
    description = "VPC name tag"
    type = string
    default = "VPC Noname"
}

variable "vpc_cidr" {
    description = "VPC CIDR"
    type = string
    default = "10.0.0.0/16"  
}