data "google_dns_managed_zone" "selected" {
  name = var.hosted_zone
}

locals {
  base_domain = "${var.environment_name}.${var.dns_suffix}"
  om_domain   = "opsmanager.${local.base_domain}"
}

resource "google_dns_managed_zone" "default" {
  name        = "${var.environment_name}-zone"
  dns_name    = "${local.base_domain}."
  description = "DNS zone for the ${var.environment_name} environment"
}

resource "google_dns_record_set" "ns" {
  managed_zone = data.google_dns_managed_zone.selected.name
  name         = "${local.base_domain}."
  type         = "NS"
  ttl          = "30"

  rrdatas = google_dns_managed_zone.default.name_servers
}

resource "google_dns_record_set" "ops_manager" {
  name = "${local.om_domain}."
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.default.name

  rrdatas = [google_compute_address.ops_manager.address]
}