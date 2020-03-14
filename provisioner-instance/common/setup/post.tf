module "post_setup" {
  source = "../../../run-script"

  name   = "post_setup"
  script = var.post_setup_script

  provisioner_host            = var.host
  provisioner_ssh_username    = var.username
  provisioner_ssh_private_key = var.private_key

  blocker = null_resource.setup.id
}