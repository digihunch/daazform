output "tls_private_key" { value = tls_private_key.example_ssh.private_key_pem}
#output "ssh_endpoint" { value = "${var.vm_admin_user}@${azurerm_linux_virtual_machine.mytftest.public_ip_address}" }
