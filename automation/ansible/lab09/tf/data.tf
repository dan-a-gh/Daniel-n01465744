#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# data.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

data "azurerm_key_vault" "n01465744_kv" {
  name                = "n01465744-kv"
  resource_group_name = "n01465744_key_vault_RG"
}

data "azurerm_key_vault_secret" "id_rsa" {
  name         = "ssh-id-rsa"
  key_vault_id = data.azurerm_key_vault.n01465744_kv.id
}

data "azurerm_key_vault_secret" "id_rsa_pub" {
  name         = "ssh-id-rsa-pub"
  key_vault_id = data.azurerm_key_vault.n01465744_kv.id
}
