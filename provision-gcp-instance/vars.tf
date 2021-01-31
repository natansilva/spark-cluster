variable "gcp_instance_image" {
    type = string
    default = "debian-cloud/debian-9"
}

variable "gcp_instance_type" {
    type = string
    default = "f1.micro"
}

variable "spark_n_nodes" {
    type = number
    default = 3
}