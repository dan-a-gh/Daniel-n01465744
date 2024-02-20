#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# outputs.tf                                                                  #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output "net_rg_name" {
  value = module.resource_groups.net_rg.name
}

output "linux_rg_name" {
  value = module.resource_groups.linux_rg.name
}

output "windows_rg_name" {
  value = module.resource_groups.windows_rg.name
}
