provider "google" {
  project     = var.project_id
  region      = var.region
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
    network = google_compute_network.spark-network.name

    access_config {
    }
  }

  metadata = {
    "ssh-keys" = "${var.ssh_username}:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "google_compute_instance" "spark-node" {
  count = var.spark_n_nodes
  name = "spark-node-${format("%02d", count.index + 1)}"
  machine_type = var.gcp_instance_type

  boot_disk {
    initialize_params {
      image = var.gcp_instance_image
    }
  }

  network_interface {
    network = google_compute_network.spark-network.name

    access_config {
    }
  }
}

resource "local_file" "ansible-inventory" {
  content = templatefile(
    "../provision-spark/templates/hosts.tmpl",
    {
      "spark_master_dns": google_compute_instance.spark-master.network_interface[0].access_config[0].nat_ip,
      "spark_node_dns": google_compute_instance.spark-node[*].network_interface[0].access_config[0].nat_ip
    }
  )
  filename = "ansible/hosts"
}

resource "local_file" "ansible-vars" {
  content = templatefile(
    "../provision-spark/templates/group_vars.tmpl",
    {
      "spark_master_dns": google_compute_instance.spark-master.network_interface[0].access_config[0].nat_ip
    }
  )
  filename = "../provision-spark/group_vars/all"
}