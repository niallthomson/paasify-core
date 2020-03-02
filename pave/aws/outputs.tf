output "ops_manager_domain" {
  value = module.infra.ops_manager_domain
}

output "ops_manager_public_ip" {
  value = module.infra.ops_manager_public_ip
}

output "ops_manager_ssh_username" {
  value = "ubuntu"
}

output "ops_manager_ssh_private_key" {
  value = module.infra.ops_manager_ssh_private_key
}

output "ops_manager_username" {
  value = module.provisioner.om_username
}

output "ops_manager_password" {
  value = module.provisioner.om_password
}

output "ops_manager_iam_role_name" {
  value = module.infra.ops_manager_iam_role_name
}

output "ops_manager_iam_user_name" {
  value = module.infra.ops_manager_iam_user_name
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

output "public_subnet_ids" {
  value = module.infra.public_subnet_ids
}

output "route_table_ids" {
  value = module.infra.route_table_ids
}

output "vms_security_group_name" {
  value = module.infra.vms_security_group_name
}

output "bucket_suffix" {
  value = module.infra.bucket_suffix
}

output "base_domain" {
  value = module.infra.base_domain
}

output "dns_zone_id" {
  value = module.infra.dns_zone_id
}

//==
output "blocker" {
  value = module.configure_director.blocker
}