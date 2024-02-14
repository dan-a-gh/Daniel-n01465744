#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
# linux_provisioner.tf                                                        #
# Created by Daniel Allison                                                   #
# n01465744                                                                   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

resource "null_resource" "linux_provisioner" {
  count = var.nb_count
  depends_on = [
    azurerm_linux_virtual_machine.linux_vm
  ]
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.linux_admin_user
      private_key = file(var.private_key)
      host        = element(azurerm_linux_virtual_machine.linux_vm[*].public_ip_address, count.index + 1)
    }
    inline = [
      "/usr/bin/hostname"
    ]
  }
}
