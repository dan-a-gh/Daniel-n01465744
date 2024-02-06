#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# vmlinux-main.tf                                                             #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

# RESOURCES
# =============================================================================

resource "azurerm_network_interface" "linux_nic" {
  count               = var.nb_count
  name                = "${var.linux_name}${format("%2d", count.index + 1)}-nic"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name

  ip_configuration {
    name                          = "${var.linux_name}${format("%2d", count.index + 1)}-ipconfig"
    subnet_id                     = azurerm_subnet.network_subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[count.index].id
  }

  tags = {
    name          = local.Name
    project       = local.Project
    contact_email = local.ContactEmail
    environment   = local.Environment
  }
}

resource "azurerm_public_ip" "linux_pip" {
  count               = var.nb_count
  name                = "${var.linux_name}${format("%2d", count.index + 1)}-pip"
  resource_group_name = azurerm_resource_group.network_rg.name
  location            = azurerm_resource_group.network_rg.location
  allocation_method   = "Dynamic"
  domain_name_label   = var.linux_name

  tags = {
    name          = local.Name
    project       = local.Project
    contact_email = local.ContactEmail
    environment   = local.Environment
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count               = var.nb_count
  name                = "${var.linux_name}${format("%2d", count.index + 1)}"
  resource_group_name = azurerm_resource_group.network_rg.name
  location            = azurerm_resource_group.network_rg.location
  size                = var.linux_size
  admin_username      = var.linux_admin_user
  computer_name       = "${var.linux_name}${format("%2d", count.index + 1)}"
  network_interface_ids = [
    element(azurerm_network_interface.linux_nic[*].id, count.index + 1),
  ]

  admin_ssh_key {
    username   = var.linux_admin_user
    public_key = file(var.public_key)
  }

  os_disk {
    caching              = var.linux_os_disk.caching
    storage_account_type = var.linux_os_disk.storage_account_type
    name                 = "${var.linux_name}${format("%2d", count.index + 1)}"
  }

  source_image_reference {
    publisher = var.linux_os.publisher
    offer     = var.linux_os.offer
    sku       = var.linux_os.sku
    version   = var.linux_os.version
  }

  tags = {
    name          = local.Name
    project       = local.Project
    contact_email = local.ContactEmail
    environment   = local.Environment
  }
}

resource "azurerm_availability_set" "linux_avs" {
  name                         = var.linux_avs
  location                     = azurerm_resource_group.network_rg.location
  resource_group_name          = azurerm_resource_group.network_rg.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}
