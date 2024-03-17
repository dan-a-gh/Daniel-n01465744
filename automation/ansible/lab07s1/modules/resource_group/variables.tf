#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# variables.tf                                                                #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

variable "net_rg" {
  type = object({
    name     = string
    location = string
  })
}

variable "linux_rg" {
  type = object({
    name     = string
    location = string
  })
}

variable "windows_rg" {
  type = object({
    name     = string
    location = string
  })
}
