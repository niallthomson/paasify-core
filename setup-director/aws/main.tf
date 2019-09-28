module "acme" {
  source = "../../acme/aws"

  dns_zone_id        = var.dns_zone_id
  opsmanager_domain  = var.om_host
  additional_domains = var.additional_cert_domains
}

module "director_config" {
  source = "../../build-director-config/aws"

  azs                         = var.azs
  iam_instance_profile        = var.iam_instance_profile
  vpc_id                      = var.vpc_id
  security_group              = var.security_group
  key_pair_name               = var.key_pair_name
  ssh_private_key             = var.ssh_private_key
  region                      = var.region
  bucket_name                 = var.bucket_name
  bucket_access_key_id        = var.bucket_access_key_id
  bucket_secret_access_key    = var.bucket_secret_access_key

  vpc_cidr                    = var.vpc_cidr
  management_subnet_ids       = var.management_subnet_ids
  management_subnet_cidrs     = var.management_subnet_cidrs
  management_subnet_azs       = var.management_subnet_azs
}

module "provisioner" {
  source = "../../provisioner-instance/aws"

  env_name    = var.env_name
  subnet_id   = var.provisioner_subnet_id
  dns_zone_id = var.dns_zone_id

  pivnet_token = var.pivnet_token
  om_host      = var.om_host

  blocker      = var.blocker
}

resource "null_resource" "provisioner_blocker" {
  depends_on = [module.provisioner]
}

module "configure_director" {
  source = "../../configure-director"

  config           = module.director_config.config
  ops_file         = module.director_config.ops_file
  bosh_director_ip = module.director_config.bosh_director_ip

  provisioner_host        = module.provisioner.dns
  provisioner_username    = module.provisioner.ssh_username
  provisioner_private_key = module.provisioner.ssh_private_key

  blocker                 = null_resource.provisioner_blocker.id
}