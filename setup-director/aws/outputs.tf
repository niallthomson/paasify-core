output "provisioner_host" {
  value = module.provisioner.dns
}

output "provisioner_ssh_username" {
  value = module.provisioner.ssh_username
}

output "provisioner_ssh_private_key" {
  value = module.provisioner.ssh_private_key
}

output "az_configuration" {
  value = module.director_config.az_configuration
}

output "cert_full_chain" {
  value = module.acme.cert_full_chain
}

output "cert_key" {
  value = module.acme.cert_key
}