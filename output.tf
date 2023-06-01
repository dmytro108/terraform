output "public_ip"{
description = "Load Balancer publick IP address"
value = aws_lb.web_balancer.dns_name
}
