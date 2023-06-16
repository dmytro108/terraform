data "aws_instances" "nodes_list" {

filter {
    name   = "instance.subnet-id"
    values = module.vpc.private_subnets
  }

}