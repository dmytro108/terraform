variable "region"{
description = "AWS region"
default = "eu-west-2a"
}
variable "ami_id"{
description = "AMI..."
type = string
}
variable "instances_per_subnet"{
description = "Num"
type = number
}
