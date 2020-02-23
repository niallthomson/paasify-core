module "common" {
  source = "../common"

  director_az = var.azs[0]
  ntp         = "metadata.google.internal"
}

module "management_subnets" {
  source = "../../build-network-config/gcp"

  subnet_name    = var.management_subnet_name
  network_name   = var.network_name
  region         = var.region
  subnet_cidr    = var.management_subnet_cidr
  subnet_gateway = var.management_subnet_gateway
  subnet_azs     = var.azs
}

data "template_file" "director_configuration" {
  template = "${chomp(file("${path.module}/templates/director_config_ops.yml"))}"

  vars = {
    az_configuration = join(", ", formatlist("{name: %s}", var.azs))

    management_subnets = "[${module.management_subnets.subnet_config}]"

    project         = "${var.project}"
    service_account = "${var.service_account_email}"
  }
}