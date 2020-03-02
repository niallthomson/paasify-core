output "environment_name" {
  value = var.environment_name
}

output "availability_zones" {
  value = var.availability_zones
}

output "network_name" {
  value = google_compute_network.network.name
}

output "base_domain" {
  value = local.base_domain
}

output "hosted_zone" {
  value = google_dns_managed_zone.default.name
}

output "vpc_cidr" {
  value = var.vpc_cidr
}

output "management_subnet_name" {
  value = google_compute_subnetwork.management.name
}

output "management_subnet_cidr" {
  value = google_compute_subnetwork.management.ip_cidr_range
}

output "management_subnet_gateway" {
  value = google_compute_subnetwork.management.gateway_address
}

output "initial_net_num" {
  description = "The initial netnum parameter that should be used to create additional subnets so as to not overlap"
  value       = 1
}

output "ops_manager_bucket" {
  value = google_storage_bucket.ops_manager.name
}

output "bucket_suffix" {
  value = random_integer.bucket_suffix.result
}

output "ops_manager_service_account_key" {
  value = base64decode(google_service_account_key.ops_manager.private_key)
}

output "ops_manager_service_account_email" {
  value = google_service_account.ops_manager.email
}

output "ops_manager_ssh_private_key" {
  value = tls_private_key.ops_manager.private_key_pem
}

output "ops_manager_ssh_public_key" {
  value = tls_private_key.ops_manager.private_key_pem
}

output "ops_manager_domain" {
  value = local.om_domain
}

output "ops_manager_public_ip" {
  value = google_compute_address.ops_manager.address
}