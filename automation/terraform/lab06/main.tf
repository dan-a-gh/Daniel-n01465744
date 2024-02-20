#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

module "resource_groups" {
  source = "./modules/resource_group"
  net_rg = {
    name     = "network_rg"
    location = "CanadaCentral"
  }
  linux_rg = {
    name     = "linux_rg"
    location = "CanadaCentral"
  }
  windows_rg = {
    name     = "windows_rg"
    location = "CanadaCentral"
  }
}
