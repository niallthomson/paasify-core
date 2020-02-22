module "setup" {
  source = "../common/setup"

  instance_id  = aws_instance.provisioner.id

  host         = aws_eip.provisioner.public_ip
  username     = local.username
  private_key  = tls_private_key.provisioner.private_key_pem

  pivnet_token = var.pivnet_token
  om_host      = var.om_host
  om_username  = var.om_username
  om_password  = local.om_password

  blocker      = var.blocker
}