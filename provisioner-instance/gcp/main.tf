resource "google_compute_firewall" "jumpbox-external" {
  name    = "${var.env_name}-jumpbox-external"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["${var.env_name}-provisioner"]
}

resource "google_compute_address" "provisioner" {
  name = "${var.env_name}-provisioner-ip"
}

resource "google_compute_instance" "provisioner" {
  name         = "${var.env_name}-provisioner"
  machine_type = var.instance_type
  zone         = var.availability_zone

  tags = ["${var.env_name}", "${var.env_name}-provisioner"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size  = var.disk_size
    }
  }

  network_interface {
    subnetwork = var.subnet_name

    access_config {
      nat_ip = google_compute_address.provisioner.address
    }
  }

  metadata = {
    ssh-keys = "${local.username}:${tls_private_key.provisioner.public_key_openssh}"
  }

  service_account {
    scopes = ["compute-ro", "storage-ro"]
  }
}

locals {
  username = "ubuntu"
}