region        = "eu-west-2" // London
vpc_name      = "web_ebl" // balanced web servers 
env_name      = "epam" //Epam devops course
vpc_cidr      = "192.168.0.0/16" //VPC CIDR
priv_net_cidrs = ["192.168.10.0/24"] // Privat nets
pub_net_cidrs  = ["192.168.1.0/24"] // Public nets
serv_num       = 2 // Quantity of servers

