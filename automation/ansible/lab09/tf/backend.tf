#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# backend.tf                                                                  #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate_n01465744_RG"
    storage_account_name = "tfstaten01465744sa"
    container_name       = "tfstatefiles"
    key                  = "tfstate"
  }
}