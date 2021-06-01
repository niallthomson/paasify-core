locals {
  username = "ubuntu"
}

resource "random_string" "provisioner" {
  length  = 20
  special = false
  upper   = false
}

resource "azurerm_storage_account" "provisioner" {
  name                     = random_string.provisioner.result
  resource_group_name      = var.resource_group_name
  location                 = var.region
  account_replication_type = "LRS"
  account_tier             = "Standard"
}

resource "azurerm_public_ip" "provisioner_public_ip" {
  name                    = "${var.env_name}-provisioner-public-ip"
  location                = var.region
  resource_group_name     = var.resource_group_name
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30

  tags = merge(
    var.tags,
    { name = "${var.env_name}-provisioner-public-ip" },
  )
}

resource "azurerm_network_interface" "provisioner_nic" {
  name                = "${var.env_name}-provisioner-nic"
  depends_on          = [azurerm_public_ip.provisioner_public_ip]
  location            = var.region
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.env_name}-provisioner-ip-config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "static"
    private_ip_address            = var.private_ip_address
    public_ip_address_id          = azurerm_public_ip.provisioner_public_ip.id
  }
}

resource "azurerm_virtual_machine" "provisioner_vm" {
  name                          = "${var.env_name}-provisioner-vm"
  depends_on                    = [azurerm_network_interface.provisioner_nic]
  location                      = var.region
  resource_group_name           = var.resource_group_name
  network_interface_ids         = [azurerm_network_interface.provisioner_nic.id]
  vm_size                       = var.instance_type
  delete_os_disk_on_termination = "true"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osDisk"
    caching           = "ReadWrite"
    os_type           = "linux"
    create_option     = "FromImage"
    disk_size_gb      = "150"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "${var.env_name}-provisioner"
    admin_username = local.username
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/ubuntu/.ssh/authorized_keys"
      key_data = tls_private_key.provisioner.public_key_openssh
    }
  }
}