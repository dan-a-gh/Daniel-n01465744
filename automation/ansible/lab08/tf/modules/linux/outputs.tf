#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# outputs.tf                                                                  #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output "linux_avs" {
  value = azurerm_availability_set.linux_avs
}

output "linux_vms" {
  value = [azurerm_linux_virtual_machine.linux_vm[*]]
}

output "linux_private_ips" {
  value = [azurerm_network_interface.linux_nic[*].private_ip_address]
}

output "linux_public_ips" {
  value = [azurerm_public_ip.linux_pip[*].ip_address]
}

output "linux_fqdn" {
  value = [azurerm_public_ip.linux_pip[*].fqdn]
}

output "linux_vm_hostnames" {
  value = [azurerm_linux_virtual_machine.linux_vm[*].name]
}