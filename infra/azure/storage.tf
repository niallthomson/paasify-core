resource "random_string" "ops_manager" {
  length  = 20
  special = false
  upper   = false
}

resource "azurerm_storage_account" "ops_manager" {
  name                      = random_string.ops_manager.result
  resource_group_name       = azurerm_resource_group.platform.name
  location                  = var.region
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true

  tags = merge(
    var.tags,
    {
      environment = var.environment_name
      name        = random_string.ops_manager.result
    },
  )
}

resource "azurerm_storage_container" "ops_manager" {
  name                  = "opsmanagerimage"
  storage_account_name  = azurerm_storage_account.ops_manager.name
  container_access_type = "private"
}

resource "random_string" "bosh" {
  length  = 20
  special = false
  upper   = false
}

resource "azurerm_storage_account" "bosh" {
  name                      = random_string.bosh.result
  location                  = var.region
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "StorageV2"
  resource_group_name       = azurerm_resource_group.platform.name
  enable_https_traffic_only = true

  tags = merge(
    var.tags,
    {
      environment = var.environment_name
      account_for = "bosh"
      name        = random_string.bosh.result
    },
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_container" "bosh" {
  name                  = "bosh"
  depends_on            = [azurerm_storage_account.bosh]
  storage_account_name  = azurerm_storage_account.bosh.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "stemcell" {
  name                  = "stemcell"
  depends_on            = [azurerm_storage_account.bosh]
  storage_account_name  = azurerm_storage_account.bosh.name
  container_access_type = "blob"
}

resource "azurerm_storage_table" "stemcells" {
  name                 = "stemcells"
  storage_account_name = azurerm_storage_account.bosh.name
}