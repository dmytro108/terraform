output "public_ip" {
  description = "Control node publick IP address"
  value       = aws_eip.controller.public_ip
}