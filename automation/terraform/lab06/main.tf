#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

module "resource_groups" {
  source = "./modules/resource_group"
  net_rg = {
    name     = "network_rg"
    location = "CanadaCentral"
  }
  linux_rg = {
    name     = "linux_rg"
    location = "CanadaCentral"
  }
  windows_rg = {
    name     = "windows_rg"
    location = "CanadaCentral"
  }
}

module "networking" {
  source = "./modules/network"
  vnet = {
    name                = "vnet"
    location            = "CanadaCentral"
    resource_group_name = module.resource_groups.net_rg.name
    address_space       = ["10.0.0.0/16"]
  }
  subnet1 = {
    name          = "subnet1"
    address_space = ["10.0.0.0/24"]
  }
  nsg1 = {
    name = "nsg1"
    sec_rule = {
      name                       = "rule1"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
  subnet2 = {
    name          = "subnet2"
    address_space = ["10.0.1.0/24"]
  }
  nsg2 = {
    name = "nsg2"
    sec_rule = {
      name                       = "rule1"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}
