#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# vmlinux-vars.tf                                                             #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

# VARIABLES
# =============================================================================

variable "linux-name" {
  type    = string
  default = "n01465744-u-vm1"
}

variable "linux-size" {
  type    = string
  default = "Standard_B1s"
}

variable "linux-admin-user" {
  type    = string
  default = "n01465744"
}

variable "public-key" {
  type    = string
  default = "/var/home/danielallison/.ssh/id_rsa.pub"
}

variable "linux-os-disk" {
  type = object({
    storage_account_type = string
    disk_size            = number
    caching              = string
  })
  default = {
    storage_account_type = "Premium_LRS"
    disk_size            = 32
    caching              = "ReadWrite"
  }
}

variable "linux-os" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "19.04"
    version   = "latest"
  }
}
