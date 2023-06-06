output "public_ip" {
  description = "Control node publick IP address"
  value       = aws_eip.controller.public_ip
}

output "privat_ips" {
  description = "Control node publick IP address"
  value = data.aws_instances.nodes_list.private_ips
}