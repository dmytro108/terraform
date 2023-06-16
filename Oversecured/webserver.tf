resource "aws_instance" "webserver" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_type
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.webserver_public_access.id]
  key_name               = aws_key_pair.webserver.key_name

  tags = {
    "Name" = "webserver"
  }
}

resource "aws_eip" "webserver_ip" {
  instance = aws_instance.webserver.id
  domain   = "vpc"
}

resource "aws_security_group" "webserver_public_access" {
  vpc_id = module.vpc.vpc_id

  for_each = toset(var.allowed_ports)
  ingress {
    from_port   = each.value
    to_port     = each.value
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip
  }

  egress {
    from_port   = each.value
    to_port     = each.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}