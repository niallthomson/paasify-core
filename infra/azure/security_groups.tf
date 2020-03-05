resource "azurerm_network_security_group" "platform_vms" {
  name                = "${var.environment_name}-platform-vms-sg"
  location            = var.region
  resource_group_name = azurerm_resource_group.platform.name
}

resource "azurerm_network_security_rule" "internal_anything" {
  name                        = "internal-anything"
  description                 = "Allow internal traffic within the network"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.platform.name
  network_security_group_name = azurerm_network_security_group.platform_vms.name
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "ssh"
  description                 = "Allow SSH to VMs in the network"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.platform.name
  network_security_group_name = azurerm_network_security_group.platform_vms.name
}

resource "azurerm_network_security_rule" "bosh_agent" {
  name                        = "bosh-agent"
  description                 = "Access to the bosh agent VM"
  priority                    = 201
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "6868"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.platform.name
  network_security_group_name = azurerm_network_security_group.platform_vms.name
}

resource "azurerm_network_security_rule" "bosh_director" {
  name                        = "bosh-director"
  description                 = "Access to the bosh director"
  priority                    = 202
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "25555"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.platform.name
  network_security_group_name = azurerm_network_security_group.platform_vms.name
}

resource "azurerm_network_security_rule" "dns" {
  name                        = "dns"
  description                 = "Allow inbound DNS resolution"
  priority                    = 203
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.platform.name
  network_security_group_name = azurerm_network_security_group.platform_vms.name
}

resource "azurerm_network_security_rule" "http" {
  name                        = "http"
  description                 = "Allow inbound HTTP from the Internet"
  priority                    = 204
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.platform.name
  network_security_group_name = azurerm_network_security_group.platform_vms.name
}

resource "azurerm_network_security_rule" "https" {
  name                        = "https"
  description                 = "Allow inbound HTTPS from the Internet"
  priority                    = 205
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.platform.name
  network_security_group_name = azurerm_network_security_group.platform_vms.name
}

resource "azurerm_network_security_rule" "loggregator" {
  name                        = "loggregator"
  description                 = "Allow inbound loggregator from the Internet"
  priority                    = 206
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "4443"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.platform.name
  network_security_group_name = azurerm_network_security_group.platform_vms.name
}

resource "azurerm_network_security_rule" "diego_ssh" {
  name                        = "diego-ssh"
  description                 = "Allow inbound Diego SSH from the Internet"
  priority                    = 207
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "2222"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.platform.name
  network_security_group_name = azurerm_network_security_group.platform_vms.name
}