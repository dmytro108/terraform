output "public_ip" {
  description = "Control node publick IP address"
  value       = aws_instance.controller.public_ip
}