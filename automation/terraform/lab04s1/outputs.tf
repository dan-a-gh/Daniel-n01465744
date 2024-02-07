#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# outputs.tf                                                                  #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

# OUTPUT VARIABLES
# =============================================================================

output "vm_hostnames" {
  value = [azurerm_linux_virtual_machine.linux_vm[*].name]
}

output "vm_fqdn" {
  value = [azurerm_public_ip.linux_pip[*].fqdn]
}

output "private_ip_addr" {
  value = [azurerm_network_interface.linux_nic[*].private_ip_address]
}

output "public_ip_addr" {
  value = [azurerm_public_ip.linux_pip[*].ip_address]
}

output "vnet_name" {
  value = azurerm_virtual_network.network_vnet.name
}

output "vnet_addr_space" {
  value = azurerm_virtual_network.network_vnet.address_space
}

output "subnet1_name" {
  value = azurerm_subnet.network_subnet1.name
}

output "subnet2_name" {
  value = azurerm_subnet.network_subnet2.name
}

output "subnet1_addr_space" {
  value = azurerm_subnet.network_subnet1.address_prefixes
}

output "subnet2_addr_space" {
  value = azurerm_subnet.network_subnet2.address_prefixes
}

output "linux_avs_name" {
  value = azurerm_availability_set.linux_avs.name
}
