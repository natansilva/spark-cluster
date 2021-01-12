variable "local_cdirs" {
    type = list
}

variable "aws_ssh_key_name" {
    type = string
}

variable "ami" {
    type = string
    default = "ami-0be2609ba883822ec"
}

variable "aws_instance_type" {
    type = string
    default = "t2.micro"
}

variable "spark_n_nodes" {
    type = number
    default = 3
}