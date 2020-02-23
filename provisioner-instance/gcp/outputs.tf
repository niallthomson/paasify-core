output "public_ip" {
  value = google_compute_address.provisioner.address
}

output "instance_id" {
  value = google_compute_instance.provisioner.id
}

output "ssh_username" {
  value = local.username
}

output "ssh_public_key" {
  value = tls_private_key.provisioner.public_key_openssh
}

output "ssh_private_key" {
  value = tls_private_key.provisioner.private_key_pem
}

output "om_host" {
  value = var.om_host
}

output "om_username" {
  value = var.om_username
}

output "om_password" {
  value = local.om_password
}

output "blocker" {
  value = module.setup.blocker
}