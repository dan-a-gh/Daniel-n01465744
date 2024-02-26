#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# outputs.tf                                                                  #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

output "net_rg" {
  value = var.net_rg
}

output "linux_rg" {
  value = var.linux_rg
}

output "windows_rg" {
  value = var.windows_rg
}
