provider "google" {
  project     = "my-project-id"
  region      = "us-central1"
}

resource "google_compute_instance" "spark-master" {
  name = "spark-master"
  machine_type = var.gcp_instance_type

  boot_disk {
    initialize_params {
      image = var.gcp_instance_image
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}

resource "google_compute_instance" "spark-mode" {
  count = var.spark_n_nodes
  name = "spark-node-${format("%02d", count.index + 1)}"
  machine_type = var.gcp_instance_type

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}

resource "local_file" "ansible-inventory" {
  content = templatefile(
    "../provision-spark/hosts.tmpl",
    {
      "spark_master_dns": aws_instance.spark-master.public_dns,
      "spark_node_dns": aws_instance.spark-node[*].public_dns
    }
  )
  filename = "ansible/hosts"
}