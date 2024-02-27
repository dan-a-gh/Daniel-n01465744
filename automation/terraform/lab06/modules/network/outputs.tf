#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# outputs.tf                                                                  #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_addr_space" {
  value = azurerm_virtual_network.vnet.address_space
}

output "subnet1_name" {
  value = azurerm_subnet.subnet1.name
}

output "subnet1_addr_space" {
  value = azurerm_subnet.subnet1.address_prefixes
}

output "subnet1_id" {
  value = azurerm_subnet.subnet1.id
}

output "subnet2_name" {
  value = azurerm_subnet.subnet2.name
}

output "subnet2_addr_space" {
  value = azurerm_subnet.subnet2.address_prefixes
}

output "subnet2_id" {
  value = azurerm_subnet.subnet2.id
}

output "nsg1_name" {
  value = azurerm_network_security_group.nsg1.name
}

output "nsg2_name" {
  value = azurerm_network_security_group.nsg2.name
}
