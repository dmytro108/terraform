region             = "eu-west-2"             // London
ec2_type           = "t2.micro"              // free tier
ec2_ami_id         = "ami-0eb260c4d5475b901" //Ubuntu 22.04
availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
vpc_name           = "ansible_lab"        // 
env_name           = "epam"               //Epam devops course
vpc_cidr           = "192.168.0.0/16"     //VPC CIDR
priv_net_cidrs     = ["192.168.1.0/24"]   // Privat nets
pub_net_cidrs      = ["192.168.101.0/24"] // Public nets
serv_num           = 2                    // Quantity of nodes
port_from          = 22
port_to            = 22
nodes_pub_key      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBQDkcwFCp4dJsothUWr9palxd3QQ7Ufw9CuA1AED9Kz ubuntu@ip-192-168-101-54"
controller_pub_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIClJmRIxBXBk+6c1rTvWiYH5ZrJBP0YmjgEzC64CpNii controller-key"
nodes_privat_key   = <<-EOT
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACBBMsCnzRwQIhabC/+RmogHLSa5vjfwfzXnn0ZerZwpWQAAAJDFuLqIxbi6
iAAAAAtzc2gtZWQyNTUxOQAAACBBMsCnzRwQIhabC/+RmogHLSa5vjfwfzXnn0ZerZwpWQ
AAAEB8yn2lzzoyqUTz2kr8YSEvOeL00KSTGnywSDEv7tOo7EEywKfNHBAiFpsL/5GaiAct
Jrm+N/B/NeefRl6tnClZAAAADWRpbWExMDhAbm9kZTE=
-----END OPENSSH PRIVATE KEY-----
EOT
