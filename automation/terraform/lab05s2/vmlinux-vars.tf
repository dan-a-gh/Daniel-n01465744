#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# vmlinux-vars.tf                                                             #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

# LOCALS
# =============================================================================

locals {
  Name         = "Terraform-Class"
  Project      = "Learning"
  ContactEmail = "n01465744"
  Environment  = "Lab"
}

# VARIABLES
# =============================================================================

variable "linux_name" {
  type    = string
  default = "n01465744-u-vm"
}

variable "linux_size" {
  type    = string
  default = "Standard_B1s"
}

variable "linux_admin_user" {
  type    = string
  default = "n01465744"
}

variable "public_key" {
  type    = string
  default = "/var/home/danielallison/.ssh/id_rsa.pub"
}

variable "private_key" {
  type    = string
  default = "/var/home/danielallison/.ssh/id_rsa"
}

variable "linux_os_disk" {
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

variable "linux_os" {
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

variable "linux_avs" {
  type    = string
  default = "linux_avs"
}

variable "nb_count" {
  type    = number
  default = 2
}
