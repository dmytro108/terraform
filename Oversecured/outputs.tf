output "public_ip" {
  description = "Control node publick IP address"
  value       = aws_eip.webserver_ip
}