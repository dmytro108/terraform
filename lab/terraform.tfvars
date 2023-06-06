region             = "eu-west-2"             // London
ec2_type           = "t2.micro"              // free tier
ec2_ami_id         = "ami-0eb260c4d5475b901" //Ubuntu 22.04
availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
<<<<<<< HEAD
vpc_name      = "ansible_lab" // 
env_name      = "epam" //Epam devops course
vpc_cidr      = "192.168.0.0/16" //VPC CIDR
priv_net_cidrs = ["192.168.1.0/24"] // Privat nets
pub_net_cidrs  = ["192.168.101.0/24"] // Public nets
serv_num       = 2 // Quantity of servers
port_from = 22
port_to = 22
