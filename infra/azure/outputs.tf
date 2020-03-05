output "environment_name" {
  value = var.environment_name
}

output "resource_group_name" {
  value = azurerm_resource_group.platform.name
}

output "base_domain" {
  value = local.base_domain
}

output "dns_zone_id" {
  value = azurerm_dns_zone.env_dns_zone.name
}

output "vpc_cidr" {
  value = var.vpc_cidr
}

output "network_name" {
  value = azurerm_virtual_network.platform.name
}

output "management_subnet_id" {
  value = azurerm_subnet.management.id
}

output "management_subnet_name" {
  value = azurerm_subnet.management.name
}

output "management_subnet_cidr" {
  value = azurerm_subnet.management.address_prefix
}

output "management_subnet_gateway" {
  value = cidrhost(azurerm_subnet.management.address_prefix, 1)
}

output "initial_net_num" {
  description = "The initial netnum parameter that should be used to create additional subnets so as to not overlap"
  value       = 2
}

output "vms_security_group_id" {
  value = azurerm_network_security_group.platform_vms.id
}

output "vms_security_group_name" {
  value = azurerm_network_security_group.platform_vms.name
}

output "ops_manager_ssh_public_key" {
  value = tls_private_key.ops_manager.public_key_openssh
}

output "ops_manager_ssh_private_key" {
  value = tls_private_key.ops_manager.private_key_pem
}

output "ops_manager_domain" {
  value = local.om_domain
}

output "ops_manager_public_ip" {
  value = azurerm_public_ip.ops_manager_public_ip.ip_address
}

output "bosh_storage_account_name" {
  value = azurerm_storage_account.bosh.name
}