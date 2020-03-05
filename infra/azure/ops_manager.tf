locals {
  ops_manager_image_uri = "https://opsmanagerwestus.blob.core.windows.net/images/ops-manager-${var.ops_manager_version}-build.${var.ops_manager_build}.vhd"
}

resource "azurerm_public_ip" "ops_manager_public_ip" {
  name                    = "${var.environment_name}-ops-manager-public-ip"
  location                = var.region
  resource_group_name     = azurerm_resource_group.platform.name
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-ops-manager-public-ip" },
  )
}

resource "azurerm_network_security_group" "ops_manager" {
  name                = "${var.environment_name}-ops-manager-network-sg"
  location            = var.region
  resource_group_name = azurerm_resource_group.platform.name

  security_rule {
    name                       = "ssh"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "http"
    priority                   = 204
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = 80
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "https"
    priority                   = 205
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = 443
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-ops-manager-network-sg" },
  )
}

resource "tls_private_key" "ops_manager" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "azurerm_storage_blob" "ops_manager_image" {
  name                   = "opsman.vhd"
  //resource_group_name    = azurerm_resource_group.platform.name
  storage_account_name   = azurerm_storage_account.ops_manager.name
  storage_container_name = azurerm_storage_container.ops_manager.name
  source_uri             = local.ops_manager_image_uri
  type                   = "Page"
}

resource "azurerm_image" "ops_manager_image" {
  name                = "ops_manager_image"
  location            = var.region
  resource_group_name = azurerm_resource_group.platform.name

  os_disk {
    os_type  = "Linux"
    os_state = "Generalized"
    blob_uri = azurerm_storage_blob.ops_manager_image.url
    size_gb  = 150
  }
}

resource "azurerm_network_interface" "ops_manager_nic" {
  name                      = "${var.environment_name}-ops-manager-nic"
  depends_on                = [azurerm_public_ip.ops_manager_public_ip]
  location                  = var.region
  resource_group_name       = azurerm_resource_group.platform.name

  ip_configuration {
    name                          = "${var.environment_name}-ops-manager-ip-config"
    subnet_id                     = azurerm_subnet.management.id
    private_ip_address_allocation = "static"
    private_ip_address            = cidrhost(local.management_subnet_cidr, 4)
    public_ip_address_id          = azurerm_public_ip.ops_manager_public_ip.id
  }
}

resource "azurerm_virtual_machine" "ops_manager_vm" {
  name                          = "${var.environment_name}-ops-manager-vm"
  depends_on                    = [azurerm_network_interface.ops_manager_nic]
  location                      = var.region
  resource_group_name           = azurerm_resource_group.platform.name
  network_interface_ids         = [azurerm_network_interface.ops_manager_nic.id]
  vm_size                       = var.ops_manager_instance_type
  delete_os_disk_on_termination = "true"

  storage_image_reference {
    id = azurerm_image.ops_manager_image.id
  }

  storage_os_disk {
    name              = "opsman-disk.vhd"
    caching           = "ReadWrite"
    os_type           = "linux"
    create_option     = "FromImage"
    disk_size_gb      = "150"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "${var.environment_name}-ops-manager"
    admin_username = "ubuntu"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/ubuntu/.ssh/authorized_keys"
      key_data = tls_private_key.ops_manager.public_key_openssh
    }
  }
}