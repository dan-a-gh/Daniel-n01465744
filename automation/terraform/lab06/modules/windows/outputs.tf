#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# outputs.tf                                                                #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output "windows_avs" {
  value = azurerm_availability_set.windows_avs
}

output "windows_vms" {
  value = values(azurerm_windows_virtual_machine.windows_vm)[*]
}

output "windows_private_ips" {
  value = values(azurerm_network_interface.windows_nic)[*].private_ip_address
}

output "windows_public_ips" {
  value = values(azurerm_public_ip.windows_pip)[*].ip_address
}

output "windows_fqdn" {
  value = values(azurerm_public_ip.windows_pip)[*].fqdn
}

output "windows_vm_hostnames" {
  value = values(azurerm_windows_virtual_machine.windows_vm)[*].name
}
