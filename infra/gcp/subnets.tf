locals {
  management_subnet_cidr = cidrsubnet(var.vpc_cidr, 4, 0)
}

resource "google_compute_subnetwork" "management" {
  name          = "${var.environment_name}-management-subnet"
  ip_cidr_range = local.management_subnet_cidr
  network       = google_compute_network.network.self_link
  region        = var.region
}