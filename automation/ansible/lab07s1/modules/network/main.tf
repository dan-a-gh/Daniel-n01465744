#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet.name
  location            = var.vnet.location
  resource_group_name = var.vnet.resource_group_name
  address_space       = var.vnet.address_space
}

# Subnet 1
# -----------------------------------------------------------------------------

resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet1.name
  resource_group_name  = var.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet1.address_space
}

resource "azurerm_network_security_group" "nsg1" {
  name                = var.nsg1.name
  location            = var.vnet.location
  resource_group_name = var.vnet.resource_group_name

  security_rule {
    name                       = var.nsg1.sec_rule.name
    priority                   = var.nsg1.sec_rule.priority
    direction                  = var.nsg1.sec_rule.direction
    access                     = var.nsg1.sec_rule.access
    protocol                   = var.nsg1.sec_rule.protocol
    source_port_range          = var.nsg1.sec_rule.source_port_range
    destination_port_range     = var.nsg1.sec_rule.destination_port_range
    source_address_prefix      = var.nsg1.sec_rule.source_address_prefix
    destination_address_prefix = var.nsg1.sec_rule.destination_address_prefix
  }
}

resource "azurerm_subnet_network_security_group_association" "network_snsga1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

# Subnet 2
# -----------------------------------------------------------------------------

resource "azurerm_subnet" "subnet2" {
  name                 = var.subnet2.name
  resource_group_name  = var.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet2.address_space
}

resource "azurerm_network_security_group" "nsg2" {
  name                = var.nsg2.name
  location            = var.vnet.location
  resource_group_name = var.vnet.resource_group_name

  security_rule {
    name                       = var.nsg2.sec_rule.name
    priority                   = var.nsg2.sec_rule.priority
    direction                  = var.nsg2.sec_rule.direction
    access                     = var.nsg2.sec_rule.access
    protocol                   = var.nsg2.sec_rule.protocol
    source_port_range          = var.nsg2.sec_rule.source_port_range
    destination_port_range     = var.nsg2.sec_rule.destination_port_range
    source_address_prefix      = var.nsg2.sec_rule.source_address_prefix
    destination_address_prefix = var.nsg2.sec_rule.destination_address_prefix
  }
  security_rule {
    name                       = var.nsg2.sec_rule2.name
    priority                   = var.nsg2.sec_rule2.priority
    direction                  = var.nsg2.sec_rule2.direction
    access                     = var.nsg2.sec_rule2.access
    protocol                   = var.nsg2.sec_rule2.protocol
    source_port_range          = var.nsg2.sec_rule2.source_port_range
    destination_port_range     = var.nsg2.sec_rule2.destination_port_range
    source_address_prefix      = var.nsg2.sec_rule2.source_address_prefix
    destination_address_prefix = var.nsg2.sec_rule2.destination_address_prefix
  }
}

resource "azurerm_subnet_network_security_group_association" "network_snsga2" {
  subnet_id                 = azurerm_subnet.subnet2.id
  network_security_group_id = azurerm_network_security_group.nsg2.id
}
