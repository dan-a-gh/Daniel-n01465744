#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# variables.tf                                                                #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

variable "linux_rg" {
  type = object({
    name     = string
    location = string
  })
}

variable "linux_avs" {
  type = object({
    name                         = string
    platform_fault_domain_count  = number
    platform_update_domain_count = number
  })
}

variable "linux_count" {
  type = number
}

variable "linux_nic" {
  type = object({
    ip_configuration = object({
      subnet_id                     = string
      private_ip_address_allocation = string
    })
  })
}

variable "linux_vm" {
  type = object({
    name                = string
    resource_group_name = string
    location            = string
    size                = string
    admin_username      = string
    os_disk = object({
      caching              = string
      storage_account_type = string
    })
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  })
}

variable "linux_pip" {
  type = object({
    allocation_method = string
  })
}

variable "public_key" {
  type = string
}

variable "private_key" {
  type = string
}

variable "linux_provisioner" {
  type = object({
    remote_exec = object({
      connection = object({
        type = string
      })
    })
  })
}
