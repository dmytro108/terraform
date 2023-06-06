resource "aws_key_pair" "controller" {
  key_name   = "controller-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFeDAAGiA68969wyfSUQbDl07CiJXzO6dttyWrqjAWKx ed25519-key-20230606"
}

resource "aws_key_pair" "nodes" {
  key_name   = "nodes-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFHknOjKdsf0+iXdfIJs2fCq5f8My7XmWB6xpqzZAzWJ ed25519-key-20230606"
}

resource "aws_instance" "nodes" {
    count                  = var.serv_num
    ami                    = var.ec2_ami_id
    instance_type          = var.ec2_type
    subnet_id              = module.vpc.private_subnets[0]
    vpc_security_group_ids = [ module.vpc.default_security_group_id ]
    key_name = aws_key_pair.nodes

    tags = {
        "Name"        = "node-${count.index}"
   }
}

resource "aws_instance" "controller" {
    ami                    = var.ec2_ami_id
    instance_type          = var.ec2_type
    subnet_id              = module.vpc.public_subnets[0]
    vpc_security_group_ids = [ aws_security_group.controller_public_access.id]
    key_name = aws_key_pair.controller

    user_data = <<-EOF
                #!/bin/sh
                apt-get update
                apt-get install -y 
                EOF

    tags = {
        "Name"        = "controller"
   }
}

resource "aws_security_group" "controller_public_access" {
    vpc_id = module.vpc.vpc_id

    ingress {
        from_port = var.port_from
        to_port = var.to_from
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = var.port_from
        to_port = var.to_from
        protocol = "tcp"
        cidr_blocks = module.vpc.private_subnets_cidr_blocks
    }
}