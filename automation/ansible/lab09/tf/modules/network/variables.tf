#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# variables.tf                                                                #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

variable "vnet" {
  type = object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
  })
}

variable "subnet1" {
  type = object({
    name          = string
    address_space = list(string)
  })
}

variable "subnet2" {
  type = object({
    name          = string
    address_space = list(string)
  })
}

variable "nsg1" {
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
}

variable "nsg2" {
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
    sec_rule2 = object({
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
}
