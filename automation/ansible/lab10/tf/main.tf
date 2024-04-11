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
    sec_rule = [
      {
        name                       = "rule1"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "rule2"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
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
    sec_rule2 = {
      name                       = "rule2"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "5985"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
  depends_on = [module.resource_groups.network_rg]
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
    name                = "n01465744-c-vm"
    resource_group_name = module.resource_groups.linux_rg.name
    location            = module.resource_groups.linux_rg.location
    size                = "Standard_B1s"
    admin_username      = "n01465744"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Premium_LRS"
    }
    source_image_reference = {
      publisher = "almalinux"
      offer     = "almalinux-x86_64"
      sku       = "9-gen2"
      version   = "latest"
    }
  }
  linux_pip = {
    allocation_method = "Dynamic"
  }
  public_key  = data.azurerm_key_vault_secret.id_rsa_pub.value
  private_key = data.azurerm_key_vault_secret.id_rsa.value
  linux_provisioner = {
    remote_exec = {
      connection = {
        type = "ssh"
      }
    }
  }
  depends_on = [module.resource_groups.linux_rg]
}

module "windows" {
  source = "./modules/windows"
  windows_rg = {
    resource_group_name = module.resource_groups.windows_rg.name
    location            = module.resource_groups.windows_rg.location
  }

  windows_vm = {
    name = {
      n01465744-w-vm1 = "Standard_B2s"
    }
    admin_username = "n01465744"
    admin_password = "Removal-Icing1-Secluding"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "StandardSSD_LRS"
    }
    source_image_reference = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-datacenter-gensecond"
      version   = "latest"
    }
    winrm_listener = "Http"
  }

  windows_avs = {
    name                         = "windows_avs"
    platform_fault_domain_count  = 2
    platform_update_domain_count = 5
  }

  windows_nic = {
    ip_configuration = {
      subnet_id                     = module.networking.subnet2_id
      private_ip_address_allocation = "Dynamic"
    }
  }

  windows_pip = {
    allocation_method = "Dynamic"
  }
  depends_on = [module.resource_groups.windows_rg]
}
