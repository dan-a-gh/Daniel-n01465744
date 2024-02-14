#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# vmwindows-main.tf                                                           #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

# RESOURCES
# =============================================================================

resource "azurerm_network_interface" "windows_nic" {
  for_each            = var.windows_name
  name                = "${each.key}-nic"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name

  ip_configuration {
    name                          = each.key
    subnet_id                     = azurerm_subnet.network_subnet2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows_pip[each.key].id
  }

  tags = {
    name          = local.Name
    project       = local.Project
    contact_email = local.ContactEmail
    environment   = local.Environment
  }
}

resource "azurerm_public_ip" "windows_pip" {
  for_each            = var.windows_name
  name                = "${each.key}-pip"
  resource_group_name = azurerm_resource_group.network_rg.name
  location            = azurerm_resource_group.network_rg.location
  allocation_method   = "Dynamic"
  domain_name_label   = each.key

  tags = {
    name          = local.Name
    project       = local.Project
    contact_email = local.ContactEmail
    environment   = local.Environment
  }
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  for_each            = var.windows_name
  name                = each.key
  resource_group_name = azurerm_resource_group.network_rg.name
  location            = azurerm_resource_group.network_rg.location
  size                = each.value
  admin_username      = var.windows_admin_user
  admin_password      = "Removal-Icing1-Secluding"
  computer_name       = each.key
  network_interface_ids = [
    azurerm_network_interface.windows_nic[each.key].id,
  ]

  os_disk {
    caching              = var.windows_os_disk.caching
    storage_account_type = var.windows_os_disk.storage_account_type
    name                 = "${each.key}-ssd"
  }

  source_image_reference {
    publisher = var.windows_os.publisher
    offer     = var.windows_os.offer
    sku       = var.windows_os.sku
    version   = var.windows_os.version
  }

  winrm_listener {
    protocol = "Http"
  }

  tags = {
    name          = local.Name
    project       = local.Project
    contact_email = local.ContactEmail
    environment   = local.Environment
  }
}

resource "azurerm_availability_set" "windows_avs" {
  name                         = var.windows_avs
  location                     = azurerm_resource_group.network_rg.location
  resource_group_name          = azurerm_resource_group.network_rg.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}
