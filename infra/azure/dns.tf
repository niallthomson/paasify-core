locals {
  base_domain = "${var.environment_name}.${var.dns_suffix}"
  om_domain   = "opsmanager.${local.base_domain}"
}

data "azurerm_dns_zone" "paasify" {
  name = var.dns_suffix
}

resource "azurerm_dns_zone" "env_dns_zone" {
  name                = local.base_domain
  resource_group_name = azurerm_resource_group.platform.name
}

resource "azurerm_dns_ns_record" "ns" {
  name                = var.environment_name
  zone_name           = data.azurerm_dns_zone.paasify.name
  resource_group_name = data.azurerm_dns_zone.paasify.resource_group_name

  ttl = 300

  records = azurerm_dns_zone.env_dns_zone.name_servers
}

resource "azurerm_dns_a_record" "ops-manager" {
  name                = "opsmanager"
  zone_name           = azurerm_dns_zone.env_dns_zone.name
  resource_group_name = azurerm_resource_group.platform.name
  ttl                 = "60"
  records             = [azurerm_public_ip.ops_manager_public_ip.ip_address]

  tags = merge(
    var.tags,
    { name = "opsmanager.${var.environment_name}" },
  )
}