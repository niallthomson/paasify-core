module "common" {
  source = "../common"

  director_az = var.azs[0]
  ntp         = "169.254.169.123"
}

data "template_file" "management_subnets" {
  template = "${chomp(file("${path.module}/templates/director_subnet_config.yml"))}"

  count = length(var.azs)

  vars = {
    id       = "${var.management_subnet_ids[count.index]}"
    dns      = "${cidrhost(var.vpc_cidr, 2)}"
    cidr     = "${var.management_subnet_cidrs[count.index]}"
    gateway  = "${cidrhost(var.management_subnet_cidrs[count.index], 1)}"
    reserved = "${cidrhost(var.management_subnet_cidrs[count.index], 0) }-${cidrhost(var.management_subnet_cidrs[count.index], 9) }"
    az       = "${var.management_subnet_azs[count.index]}"
  }
}

locals {
  ssh_private_key_encoded = "${jsonencode(var.ssh_private_key)}"
}

data "template_file" "director_configuration" {
  template = "${chomp(file("${path.module}/templates/director_config_ops.yml"))}"

  vars = {
    az_configuration = join(", ", formatlist("{name: %s}", var.azs))

    management_subnets = "${join("\n", data.template_file.management_subnets.*.rendered)}"

    iam_instance_profile        = var.iam_instance_profile
    vpc_id                      = var.vpc_id
    security_group              = var.security_group
    key_pair_name               = var.key_pair_name
    ssh_private_key             = "${substr(local.ssh_private_key_encoded, 1, length(local.ssh_private_key_encoded)-2)}"
    region                      = var.region
    bucket_name                 = var.bucket_name
    bucket_access_key_id        = var.bucket_access_key_id
    bucket_secret_access_key    = var.bucket_secret_access_key
    ebs_encryption              = var.ebs_encryption
  }
}