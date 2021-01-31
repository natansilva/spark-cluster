variable "project_id" {
    type = string
}

variable "region" {
    type    = string
    default = "us-central1"
}

variable "local_cdirs" {
    type = list
}

variable "ssh_username" {
  type = string
}

variable "gcp_instance_image" {
    type    = string
    default = "debian-cloud/debian-9"
}

variable "gcp_instance_type" {
    type    = string
    default = "f1.micro"
}

variable "spark_n_nodes" {
    type    = number
    default = 3
}