output "opsman_host" {
  value = module.provisoner.om_host
}

output "opsman_username" {
  value = module.provisoner.om_username
}

output "opsman_password" {
  value = module.provisoner.om_password
}

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

output "blocker" {
  value = module.configure_director.blocker
}