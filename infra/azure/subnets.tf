locals {
  management_subnet_cidr = cidrsubnet(var.vpc_cidr, 4, 0)
}

resource "azurerm_subnet" "management" {
  name = "${var.environment_name}-management-subnet"

  resource_group_name  = azurerm_resource_group.platform.name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefix       = local.management_subnet_cidr
}

resource "azurerm_subnet_network_security_group_association" "ops_manager" {
  subnet_id                 = azurerm_subnet.management.id
  network_security_group_id = azurerm_network_security_group.ops_manager.id

  depends_on = [
    azurerm_subnet.management,
    azurerm_network_security_group.ops_manager
  ]
}