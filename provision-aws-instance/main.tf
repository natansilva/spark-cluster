terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "spark-master" {
  ami = var.ami
  vpc_security_group_ids = [ aws_security_group.spark_vpc.id ]
  instance_type = var.aws_instance_type
  key_name = var.aws_ssh_key_name
  tags = {
    "Name" = "spark-master"
  }
}

resource "aws_instance" "spark-node" {
  count = var.spark_n_nodes
  ami = var.ami
  vpc_security_group_ids = [ aws_security_group.spark_vpc.id ]
  instance_type = var.aws_instance_type
  key_name = var.aws_ssh_key_name
  tags = {
    "Name" = "spark-node-${format("%02d", count.index + 1)}"
  }
  
}

resource "local_file" "ansible-inventory" {
  content = templatefile(
    "../provision-spark/templates/hosts.tmpl",
    {
      "spark_master_dns": aws_instance.spark-master.public_dns,
      "spark_node_dns": aws_instance.spark-node[*].public_dns
    }
  )
  filename = "../provision-spark/hosts"
}

resource "local_file" "ansible-inventory" {
  content = templatefile(
    "../provision-spark/templates/group_vars.tmpl",
    {
      "spark_master_dns": aws_instance.spark-master.public_dns
    }
  )
  filename = "../provision-spark/group_vars/all"
}