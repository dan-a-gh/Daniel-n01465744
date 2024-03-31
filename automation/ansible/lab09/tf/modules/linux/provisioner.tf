#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# provisioner.tf                                                              #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

resource "null_resource" "linux_provisioner" {
  count = var.linux_count
  depends_on = [
    azurerm_linux_virtual_machine.linux_vm
  ]
  provisioner "remote-exec" {
    connection {
      type        = var.linux_provisioner.remote_exec.connection.type
      user        = var.linux_vm.admin_username
      private_key = file(var.private_key)
      host        = element(azurerm_linux_virtual_machine.linux_vm[*].public_ip_address, count.index + 1)
    }
    inline = [
      "/usr/bin/hostname"
    ]
  }
}