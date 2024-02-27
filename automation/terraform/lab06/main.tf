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

module "networking" {
  source = "./modules/network"
  vnet = {
    name                = "vnet"
    location            = "CanadaCentral"
    resource_group_name = module.resource_groups.net_rg.name
    address_space       = ["10.0.0.0/16"]
  }
  subnet1 = {
    name          = "subnet1"
    address_space = ["10.0.0.0/24"]
  }
  nsg1 = {
    name = "nsg1"
    sec_rule = {
      name                       = "rule1"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
  subnet2 = {
    name          = "subnet2"
    address_space = ["10.0.1.0/24"]
  }
  nsg2 = {
    name = "nsg2"
    sec_rule = {
      name                       = "rule1"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

module "linux" {
  source = "./modules/linux"
  linux_rg = {
    name     = module.resource_groups.linux_rg.name
    location = module.resource_groups.linux_rg.location
  }
  linux_avs = {
    name                         = "linux_avs"
    platform_fault_domain_count  = 2
    platform_update_domain_count = 5
  }
  linux_count = 2
  linux_nic = {
    ip_configuration = {
      subnet_id                     = module.networking.subnet1_id
      private_ip_address_allocation = "Dynamic"
    }
  }
  linux_vm = {
    name                = "n01465744-u-vm"
    resource_group_name = module.resource_groups.linux_rg.name
    location            = module.resource_groups.linux_rg.location
    size                = "Standard_B1s"
    admin_username      = "n01465744"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Premium_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "19.04"
      version   = "latest"
    }
  }
  linux_pip = {
    allocation_method = "Dynamic"
  }
  public_key  = "/var/home/danielallison/.ssh/id_rsa.pub"
  private_key = "/var/home/danielallison/.ssh/id_rsa"
  linux_provisioner = {
    remote_exec = {
      connection = {
        type = "ssh"
      }
    }
  }
}
