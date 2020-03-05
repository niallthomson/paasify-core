resource "azurerm_virtual_network" "platform" {
  name                = "${var.environment_name}-platform"
  depends_on          = [azurerm_resource_group.platform]
  resource_group_name = azurerm_resource_group.platform.name
  address_space       = [var.vpc_cidr]
  location            = var.region

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-platform" },
  )
}