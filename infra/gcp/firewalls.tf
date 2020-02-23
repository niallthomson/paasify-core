resource "google_compute_firewall" "ops_manager" {
  name    = "${var.environment_name}-ops-manager"
  network = google_compute_network.network.name

  direction = "INGRESS"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  target_tags = ["${var.environment_name}-ops-manager"]
}

resource "google_compute_firewall" "internal" {
  name    = "${var.environment_name}-internal"
  network = google_compute_network.network.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  source_ranges = [
    var.vpc_cidr,
  ]
}