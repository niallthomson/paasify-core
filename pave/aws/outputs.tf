output "ops_manager_domain" {
  value = module.infra.ops_manager_domain
}

output "ops_manager_username" {
  value = module.provisioner.om_username
}

output "ops_manager_password" {
  value = module.provisioner.om_password
}

output "provisioner_public_ip" {
  value = module.provisioner.public_ip
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

output "vpc_id" {
  value = module.infra.vpc_id
}

output "availability_zones" {
  value = module.infra.availability_zones
}

output "public_subnet_ids" {
  value = module.infra.public_subnet_ids
}

output "bucket_suffix" {
  value = module.infra.bucket_suffix
}

output "blocker" {
  value = module.configure_director.blocker
}