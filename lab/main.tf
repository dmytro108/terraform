data "aws_instances" "nodes_list" {

filter {
    name   = "subnet-id"
    values = module.vpc.private_subnets
  }

}
