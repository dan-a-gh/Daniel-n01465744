#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# vmwindows-vars.tf                                                           #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

# VARIABLES
# =============================================================================

variable "windows_name" {
  type = map(string)
  default = {
    n01465744-w-vm1 = "Standard_B1s"
    n01465744-w-vm2 = "Standard_B1ms"
  }
}

variable "windows_admin_user" {
  type    = string
  default = "n01465744"
}

variable "windows_public_key" {
  type    = string
  default = "/var/home/danielallison/.ssh/id_rsa.pub"
}

variable "windows_os_disk" {
  type = object({
    storage_account_type = string
    disk_size            = number
    caching              = string
  })
  default = {
    storage_account_type = "StandardSSD_LRS"
    disk_size            = 128
    caching              = "ReadWrite"
  }
}

variable "windows_os" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

variable "windows_avs" {
  type    = string
  default = "windows_avs"
}
