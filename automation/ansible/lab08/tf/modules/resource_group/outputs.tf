#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# outputs.tf                                                                  #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output "net_rg" {
  value = azurerm_resource_group.network_rg
}

output "linux_rg" {
  value = azurerm_resource_group.linux_rg
}

output "windows_rg" {
  value = azurerm_resource_group.windows_rg
}
