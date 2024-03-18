resource "null_resource" "linux_provisioner" {
  for_each   = var.linux_name
  depends_on = [azurerm_linux_virtual_machine.linux-vm]

  provisioner "remote-exec" {
    inline = ["/usr/bin/hostname"]
  }

  connection {
    type        = "ssh"
    user        = var.admin_username
    private_key = file(var.private_key_path)
    host        = azurerm_public_ip.linux-pip[each.key].fqdn
  }
}