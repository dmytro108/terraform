resource "aws_key_pair" "webserver" {
  key_name   = "webserver-key"
  public_key = var.webserever_pub_key
}