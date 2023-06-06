resource "aws_instance" "nodes" {
  count                  = var.serv_num
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_type
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.nodes.id]
  key_name               = aws_key_pair.nodes.key_name

  tags = {
    "Name" = "node-${count.index}"
  }
}

resource "aws_security_group" "nodes" {
  vpc_id = module.vpc.vpc_id
  ingress {
    from_port   = var.port_from
    to_port     = var.port_to
    protocol    = "tcp"
    cidr_blocks = var.pub_net_cidrs
  }

  egress {
    from_port   = var.port_from
    to_port     = var.port_to
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
