module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  cidr            = var.vpc_cidr
  azs             = var.availability_zones
  private_subnets = var.priv_net_cidrs
  public_subnets  = var.pub_net_cidrs

  enable_nat_gateway = true
  enable_vpn_gateway = false
  enable_ipv6 = false

  default_security_group_name = "ansible_nodes"
  default_security_group_ingress = [
    {  "from_port" = var.port_from
        "to_port" = var.port_to
        "protocol" = "tcp"
        "cidr_blocks" = var.pub_net_cidrs
    }
    ]
  default_security_group_egress = [
    {   "from_port" = var.port_from
        "to_port" = var.port_to
        "protocol" = "tcp"
        "cidr_blocks" = ["0.0.0.0/0"]
    }
    ]

  tags = {
    "Name"        = var.vpc_name
  }
}