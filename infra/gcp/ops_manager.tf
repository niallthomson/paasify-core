locals {
  opsman_image_url = "https://storage.googleapis.com/ops-manager-us/pcf-gcp-${var.ops_manager_version}-build.${var.ops_manager_build}.tar.gz"
}

resource "google_compute_address" "ops_manager" {
  name = "${var.environment_name}-ops-manager-ip"
}

resource "tls_private_key" "ops_manager" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "google_compute_image" "ops_manager_image" {
  name = "${var.environment_name}-ops-manager-image"

  timeouts {
    create = "20m"
  }

  raw_disk {
    source = "https://storage.googleapis.com/ops-manager-${replace(local.opsman_image_url, "/.*ops-manager-(.*)/", "$1")}"
  }
}

resource "google_compute_instance" "ops_manager" {
  name         = "${var.environment_name}-ops-manager"
  machine_type = var.ops_manager_instance_type
  zone         = element(var.availability_zones, 1)
  tags         = ["${var.environment_name}-ops-manager"]

  timeouts {
    create = var.ops_man_image_creation_timeout
  }

  boot_disk {
    initialize_params {
      image = google_compute_image.ops_manager_image.self_link
      type  = "pd-ssd"
      size  = 150
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.management.name

    access_config {
      nat_ip = google_compute_address.ops_manager.address
    }
  }

  service_account {
    email  = google_service_account.ops_manager.email
    scopes = ["cloud-platform"]
  }

  metadata = {
    ssh-keys               = format("ubuntu:%s", tls_private_key.ops_manager.public_key_openssh)
    block-project-ssh-keys = "TRUE"
  }
}