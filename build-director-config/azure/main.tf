module "common" {
  source = "../common"

  director_az = var.azs[0]
  ntp         = "ntp.ubuntu.com"
}

module "management_subnets" {
  source = "../../build-network-config/azure"

  subnet_name    = var.management_subnet_name
  network_name   = var.network_name
  subnet_cidr    = var.management_subnet_cidr
  subnet_gateway = var.management_subnet_gateway
  subnet_azs     = var.azs
}

locals {
  ssh_private_key_encoded = "${jsonencode(var.ssh_private_key)}"
  ssh_public_key_encoded  = "${jsonencode(var.ssh_public_key)}"
}

data "template_file" "director_configuration" {
  template = "${chomp(file("${path.module}/templates/director_config_ops.yml"))}"

  vars = {
    az_configuration = join(", ", formatlist("{name: %s}", var.azs))

    management_subnets = "[${module.management_subnets.subnet_config}]"

    subscription_id = "${var.subscription_id}"
    tenant_id       = "${var.tenant_id}"
    client_id       = "${var.client_id}"
    client_secret   = "${var.client_secret}"

    resource_group_name       = var.resource_group_name
    bosh_storage_account_name = var.bosh_storage_account_name
    ssh_public_key            = "${substr(local.ssh_public_key_encoded, 1, length(local.ssh_public_key_encoded) - 2)}"
    ssh_private_key           = "${substr(local.ssh_private_key_encoded, 1, length(local.ssh_private_key_encoded) - 2)}"
  }
}