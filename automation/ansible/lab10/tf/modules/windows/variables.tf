#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# variables.tf                                                                #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

variable "windows_rg" {
  type = object({
    resource_group_name = string
    location            = string
  })
}

variable "windows_vm" {
  type = object({
    name           = map(string)
    admin_username = string
    admin_password = string
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
    winrm_listener = string
  })
}

variable "windows_avs" {
  type = object({
    name                         = string
    platform_fault_domain_count  = number
    platform_update_domain_count = number
  })
}

variable "windows_nic" {
  type = object({
    ip_configuration = object({
      subnet_id                     = string
      private_ip_address_allocation = string
    })
  })
}

variable "windows_pip" {
  type = object({
    allocation_method = string
  })
}
