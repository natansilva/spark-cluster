resource "aws_security_group" "spark_vpc" {
  name        = "spark_vpc"
  description = "Spark vpc"

  ingress {
    description = "Comunication between master and worker"
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self = true
  }

  egress {
    description = "Comunication between master and worker"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    description = "Ansible ssh"
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = var.local_cdirs
  }

  ingress {
    description = "Spark master UI"
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = var.local_cdirs
  }

  ingress {
    description = "Spark worker UI"
    from_port = 8081
    to_port   = 8081
    protocol  = "tcp"
    cidr_blocks = var.local_cdirs
  }

  ingress {
    description = "Spark history server"
    from_port = 18080
    to_port   = 18080
    protocol  = "tcp"
    cidr_blocks = var.local_cdirs
  }
} 