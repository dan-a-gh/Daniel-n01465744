#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# outputs.tf                                                                  #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

# RESOURCE GROUPS
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

output "net_rg_name" {
  value = module.resource_groups.net_rg.name
}

output "linux_rg_name" {
  value = module.resource_groups.linux_rg.name
}

output "windows_rg_name" {
  value = module.resource_groups.windows_rg.name
}

# NETWORKING
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

output "vnet_name" {
  value = module.networking.vnet_name
}

output "vnet_addr_space" {
  value = module.networking.vnet_addr_space
}

output "subnet1_name" {
  value = module.networking.subnet1_name
}

output "subnet1_addr_space" {
  value = module.networking.subnet1_addr_space
}

output "nsg1_name" {
  value = module.networking.nsg1_name
}

output "subnet2_name" {
  value = module.networking.subnet1_name
}

output "subnet2_addr_space" {
  value = module.networking.subnet2_addr_space
}

output "nsg2_name" {
  value = module.networking.nsg2_name
}

# LINUX
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

output "linux_vm_hostnames" {
  value = module.linux.linux_vm_hostnames
}

output "linux_fqdn" {
  value = module.linux.linux_fqdn
}

output "linux_private_ips" {
  value = module.linux.linux_private_ips
}

output "linux_public_ips" {
  value = module.linux.linux_public_ips
}