#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# network-vars.tf                                                             #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

# VARIABLES
# =============================================================================

variable "rg" {
  type    = string
  default = "network_rg"
}

variable "location" {
  type    = string
  default = "Canada Central"
}

variable "vnet" {
  type    = string
  default = "net"
}

variable "vnet_addr_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet1" {
  type    = string
  default = "network_subnet1"
}

variable "subnet2" {
  type    = string
  default = "network_subnet2"
}

variable "subnet1_addr_space" {
  type    = list(string)
  default = ["10.0.0.0/24"]
}

variable "subnet2_addr_space" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "nsg1" {
  type = object({
    name = string
    sec_rule = object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    })
  })
  default = {
    name = "network_nsg1"
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
}

variable "nsg2" {
  type = object({
    name = string
    sec_rule = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  })
  default = {
    name = "network_nsg2"
    sec_rule = [{
      name                       = "rule1"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      },

      {
        name                       = "rule2"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "5985"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }]
  }
}