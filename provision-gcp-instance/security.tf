resource "google_compute_network" "spark-network" {
  name = "spark-network"
}

resource "google_compute_firewall" "default" {
 name    = "spark-firewall"
 network = google_compute_network.spark-network.name

  allow {
    protocol = "tcp"
    ports    = ["8080", "8181", "18080"]
  }

  allow {
    protocol = "ssh"
    ports    = ["22"]
  }
}