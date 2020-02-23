module "infra" {
  source = "../../infra/aws"

  environment_name    = var.environment_name
  region              = var.region

  availability_zones  = var.availability_zones
  dns_suffix          = var.dns_suffix
  ops_manager_version = var.ops_manager_version
  ops_manager_build   = var.ops_manager_build
}

resource "null_resource" "infra_blocker" {
  depends_on = [module.infra]
}

module "acme" {
  source = "../../acme/aws"

  dns_zone_id        = module.infra.dns_zone_id
  opsmanager_domain  = module.infra.ops_manager_domain
  additional_domains = var.additional_cert_domains
}

module "director_config" {
  source = "../../build-director-config/aws"

  azs                         = var.availability_zones
  iam_instance_profile        = module.infra.ops_manager_iam_instance_profile_name
  vpc_id                      = module.infra.vpc_id
  security_group              = module.infra.vms_security_group_id
  key_pair_name               = module.infra.ops_manager_ssh_public_key_name
  ssh_private_key             = module.infra.ops_manager_ssh_private_key
  region                      = var.region
  bucket_name                 = module.infra.ops_manager_bucket
  bucket_access_key_id        = module.infra.ops_manager_iam_user_access_key
  bucket_secret_access_key    = module.infra.ops_manager_iam_user_secret_key

  vpc_cidr                    = module.infra.vpc_cidr
  management_subnet_ids       = module.infra.management_subnet_ids
  management_subnet_cidrs     = module.infra.management_subnet_cidrs
  management_subnet_azs       = module.infra.management_subnet_availability_zones
}

module "provisioner" {
  source = "../../provisioner-instance/aws"

  env_name    = var.environment_name
  subnet_id   = module.infra.public_subnet_ids[0]
  dns_zone_id = module.infra.dns_zone_id

  pivnet_token = var.pivnet_token
  om_host      = module.infra.ops_manager_domain

  secrets      = var.secrets

  blocker      = null_resource.infra_blocker.id
}

resource "null_resource" "provisioner_blocker" {
  depends_on = [module.provisioner]
}

module "configure_director" {
  source = "../../configure-director"

  config           = module.director_config.config
  ops_file         = "${module.director_config.ops_file}\n\n${var.director_ops_file}"
  bosh_director_ip = module.director_config.bosh_director_ip

  provisioner_host        = module.provisioner.dns
  provisioner_username    = module.provisioner.ssh_username
  provisioner_private_key = module.provisioner.ssh_private_key

  blocker                 = null_resource.provisioner_blocker.id
}