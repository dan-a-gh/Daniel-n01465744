#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# vmlinux-main.tf                                                             #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

# RESOURCES
# =============================================================================

resource "azurerm_network_interface" "linux_nic" {
  name                = "${var.linux_name}-nic"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name

  ip_configuration {
    name                          = "${var.linux_name}-ipconfig"
    subnet_id                     = azurerm_subnet.network_subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip.id
  }
}

resource "azurerm_public_ip" "linux_pip" {
  name                = "${var.linux_name}-pip"
  resource_group_name = azurerm_resource_group.network_rg.name
  location            = azurerm_resource_group.network_rg.location
  allocation_method   = "Dynamic"
  domain_name_label   = var.linux_name
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = var.linux_name
  resource_group_name = azurerm_resource_group.network_rg.name
  location            = azurerm_resource_group.network_rg.location
  size                = var.linux_size
  admin_username      = var.linux_admin_user
  network_interface_ids = [
    azurerm_network_interface.linux_nic.id,
  ]

  admin_ssh_key {
    username   = var.linux_admin_user
    public_key = file(var.public_key)
  }

  os_disk {
    caching              = var.linux_os_disk.caching
    storage_account_type = var.linux_os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.linux_os.publisher
    offer     = var.linux_os.offer
    sku       = var.linux_os.sku
    version   = var.linux_os.version
  }
}
