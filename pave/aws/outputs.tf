output "ops_manager_domain" {
  value = module.infra.ops_manager_domain
}

output "ops_manager_username" {
  value = module.setup_director.opsman_username
}

output "ops_manager_password" {
  value = module.setup_director.opsman_password
}

output "provisioner_public_ip" {
  value = module.setup_director.provisioner_public_ip
}

output "provisioner_host" {
  value = module.setup_director.provisioner_host
}

output "provisioner_ssh_username" {
  value = module.setup_director.provisioner_ssh_username
}

output "provisioner_ssh_private_key" {
  value = module.setup_director.provisioner_ssh_private_key
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
  value = module.setup_director.blocker
}