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
nodes_pub_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEEywKfNHBAiFpsL/5GaiActJrm+N/B/NeefRl6tnClZ dima108@node1"
controller_pub_key = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBAjbDO9fWJqZhkR/IzjZ7xs8vnGnycA17tvM3OKpEsYQ2DTBbtKeSGmMRNQ7VqE+0RRUkI40WGHRGCRMbDnA93M= ecdsa-key-20230606"
nodes_privat_key = <<-EOF
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACBBMsCnzRwQIhabC/+RmogHLSa5vjfwfzXnn0ZerZwpWQAAAJDFuLqIxbi6
iAAAAAtzc2gtZWQyNTUxOQAAACBBMsCnzRwQIhabC/+RmogHLSa5vjfwfzXnn0ZerZwpWQ
AAAEB8yn2lzzoyqUTz2kr8YSEvOeL00KSTGnywSDEv7tOo7EEywKfNHBAiFpsL/5GaiAct
Jrm+N/B/NeefRl6tnClZAAAADWRpbWExMDhAbm9kZTE=
-----END OPENSSH PRIVATE KEY-----
EOF