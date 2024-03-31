#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

resource "azurerm_resource_group" "network_rg" {
  name     = var.net_rg.name
  location = var.net_rg.location
}

resource "azurerm_resource_group" "linux_rg" {
  name     = var.linux_rg.name
  location = var.linux_rg.location
}

resource "azurerm_resource_group" "windows_rg" {
  name     = var.windows_rg.name
  location = var.windows_rg.location
}
