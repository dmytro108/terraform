resource "aws_key_pair" "controller" {
  key_name   = "controller-key"
  public_key = var.controller_pub_key
}

resource "aws_key_pair" "nodes" {
  key_name   = "nodes-key"
  public_key = var.nodes_pub_key
}