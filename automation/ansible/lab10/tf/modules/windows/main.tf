#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# main.tf                                                                     #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

resource "azurerm_network_interface" "windows_nic" {
  for_each            = var.windows_vm.name
  name                = "${each.key}-nic"
  location            = var.windows_rg.location
  resource_group_name = var.windows_rg.resource_group_name

  ip_configuration {
    name                          = each.key
    subnet_id                     = var.windows_nic.ip_configuration.subnet_id
    private_ip_address_allocation = var.windows_nic.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.windows_pip[each.key].id
  }
}

resource "azurerm_public_ip" "windows_pip" {
  for_each            = var.windows_vm.name
  name                = "${each.key}-pip"
  resource_group_name = var.windows_rg.resource_group_name
  location            = var.windows_rg.location
  allocation_method   = var.windows_pip.allocation_method
  domain_name_label   = each.key
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  for_each            = var.windows_vm.name
  name                = each.key
  resource_group_name = var.windows_rg.resource_group_name
  location            = var.windows_rg.location
  size                = each.value
  admin_username      = var.windows_vm.admin_username
  admin_password      = var.windows_vm.admin_password
  computer_name       = each.key
  network_interface_ids = [
    azurerm_network_interface.windows_nic[each.key].id,
  ]

  os_disk {
    caching              = var.windows_vm.os_disk.caching
    storage_account_type = var.windows_vm.os_disk.storage_account_type
    name                 = "${each.key}-ssd"
  }

  source_image_reference {
    publisher = var.windows_vm.source_image_reference.publisher
    offer     = var.windows_vm.source_image_reference.offer
    sku       = var.windows_vm.source_image_reference.sku
    version   = var.windows_vm.source_image_reference.version
  }

  winrm_listener {
    protocol = var.windows_vm.winrm_listener
  }
}

resource "azurerm_availability_set" "windows_avs" {
  name                         = var.windows_avs.name
  location                     = var.windows_rg.location
  resource_group_name          = var.windows_rg.resource_group_name
  platform_fault_domain_count  = var.windows_avs.platform_fault_domain_count
  platform_update_domain_count = var.windows_avs.platform_update_domain_count
}
