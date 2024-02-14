#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# network-main.tf                                                             #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

# RESOURCES
# =============================================================================

resource "azurerm_resource_group" "network_rg" {
  name     = var.rg
  location = var.location
}

resource "azurerm_virtual_network" "network_vnet" {
  name                = var.vnet
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  address_space       = var.vnet_addr_space
}

# Subnet 1
# -----------------------------------------------------------------------------

resource "azurerm_subnet" "network_subnet1" {
  name                 = var.subnet1
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.network_vnet.name
  address_prefixes     = var.subnet1_addr_space
}

resource "azurerm_network_security_group" "network_nsg1" {
  name                = var.nsg1.name
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name

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
  subnet_id                 = azurerm_subnet.network_subnet1.id
  network_security_group_id = azurerm_network_security_group.network_nsg1.id
}

# Subnet 2
# -----------------------------------------------------------------------------

resource "azurerm_subnet" "network_subnet2" {
  name                 = var.subnet2
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.network_vnet.name
  address_prefixes     = var.subnet2_addr_space
}

resource "azurerm_network_security_group" "network_nsg2" {
  name                = var.nsg2.name
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name

  security_rule {
    name                       = var.nsg2.sec_rule[0].name
    priority                   = var.nsg2.sec_rule[0].priority
    direction                  = var.nsg2.sec_rule[0].direction
    access                     = var.nsg2.sec_rule[0].access
    protocol                   = var.nsg2.sec_rule[0].protocol
    source_port_range          = var.nsg2.sec_rule[0].source_port_range
    destination_port_range     = var.nsg2.sec_rule[0].destination_port_range
    source_address_prefix      = var.nsg2.sec_rule[0].source_address_prefix
    destination_address_prefix = var.nsg2.sec_rule[0].destination_address_prefix
  }

  security_rule {
    name                       = var.nsg2.sec_rule[1].name
    priority                   = var.nsg2.sec_rule[1].priority
    direction                  = var.nsg2.sec_rule[1].direction
    access                     = var.nsg2.sec_rule[1].access
    protocol                   = var.nsg2.sec_rule[1].protocol
    source_port_range          = var.nsg2.sec_rule[1].source_port_range
    destination_port_range     = var.nsg2.sec_rule[1].destination_port_range
    source_address_prefix      = var.nsg2.sec_rule[1].source_address_prefix
    destination_address_prefix = var.nsg2.sec_rule[1].destination_address_prefix
  }
}

resource "azurerm_subnet_network_security_group_association" "network_snsga2" {
  subnet_id                 = azurerm_subnet.network_subnet2.id
  network_security_group_id = azurerm_network_security_group.network_nsg2.id
}