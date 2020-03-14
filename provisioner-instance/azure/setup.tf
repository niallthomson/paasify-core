module "setup" {
  source = "../common/setup"

  instance_id = azurerm_virtual_machine.provisioner_vm.id

  host        = azurerm_public_ip.provisioner_public_ip.ip_address
  username    = local.username
  private_key = tls_private_key.provisioner.private_key_pem

  pivnet_token = var.pivnet_token
  om_host      = var.om_host
  om_username  = var.om_username
  om_password  = local.om_password

  post_setup_script = var.post_setup_script

  blocker = var.blocker
}