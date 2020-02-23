output "ops_manager_domain" {
  value = module.infra.ops_manager_domain
}

output "ops_manager_username" {
  value = module.provisioner.om_username
}

output "ops_manager_password" {
  value = module.provisioner.om_password
}

output "provisioner_host" {
  value = module.provisioner.public_ip
}

output "provisioner_ssh_username" {
  value = module.provisioner.ssh_username
}

output "provisioner_ssh_private_key" {
  value = module.provisioner.ssh_private_key
}

output "network_name" {
  value = module.infra.network_name
}

output "vpc_cidr" {
  value = module.infra.vpc_cidr
}

output "availability_zones" {
  value = module.infra.availability_zones
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

output "cert_ca" {
  value = module.acme.cert_ca
}

output "base_domain" {
  value = module.infra.base_domain
}

//==
output "blocker" {
  value = module.configure_director.blocker
}