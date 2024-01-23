#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# vmlinux-main.tf                                                             #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

# RESOURCES
# =============================================================================

resource "azurerm_network_interface" "linux-nic" {
  name                = "${var.linux-name}-nic"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name

  ip_configuration {
    name                          = "${var.linux-name}-ipconfig"
    subnet_id                     = azurerm_subnet.network-subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux-pip.id
  }
}

resource "azurerm_public_ip" "linux-pip" {
  name                = "${var.linux-name}-pip"
  resource_group_name = azurerm_resource_group.network-rg.name
  location            = azurerm_resource_group.network-rg.location
  allocation_method   = "Dynamic"
  domain_name_label   = var.linux-name
}

resource "azurerm_linux_virtual_machine" "linux-vm" {
  name                = var.linux-name
  resource_group_name = azurerm_resource_group.network-rg.name
  location            = azurerm_resource_group.network-rg.location
  size                = var.linux-size
  admin_username      = var.linux-admin-user
  network_interface_ids = [
    azurerm_network_interface.linux-nic.id,
  ]

  admin_ssh_key {
    username   = var.linux-admin-user
    public_key = file(var.public-key)
  }

  os_disk {
    caching              = var.linux-os-disk.caching
    storage_account_type = var.linux-os-disk.storage_account_type
  }

  source_image_reference {
    publisher = var.linux-os.publisher
    offer     = var.linux-os.offer
    sku       = var.linux-os.sku
    version   = var.linux-os.version
  }
}
