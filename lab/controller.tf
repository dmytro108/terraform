resource "aws_instance" "controller" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_type
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.controller_public_access.id]
  key_name               = aws_key_pair.controller.key_name

  user_data = <<-EOF
                #!/bin/sh
                python3 -m pip -V
                curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
                python3 get-pip.py
                python3 -m pip install ansible
EOF

  tags = {
    "Name" = "controller"
  }
}

resource "aws_eip" "controller" {
  instance = aws_instance.controller.id
  domain   = "vpc"
}

resource "aws_security_group" "controller_public_access" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = var.port_from
    to_port     = var.port_to
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = var.port_from
    to_port     = var.port_to
    protocol    = "tcp"
    cidr_blocks = module.vpc.private_subnets_cidr_blocks
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}