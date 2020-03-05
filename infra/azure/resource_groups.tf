resource "azurerm_resource_group" "platform" {
  name     = var.environment_name
  location = var.region

  tags = merge(
    var.tags,
    { name = "${var.environment_name}" },
  )
}