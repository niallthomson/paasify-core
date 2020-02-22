provider "aws" {
  region = var.region

  version = "~> 2.50.0"
}

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

module "setup_director" {
  source = "../../setup-director/aws"

  env_name                    = module.infra.environment_name
  provisioner_subnet_id       = module.infra.public_subnet_ids[0]
  dns_zone_id                 = module.infra.dns_zone_id
  pivnet_token                = var.pivnet_token
  om_host                     = module.infra.ops_manager_domain

  azs                         = module.infra.availability_zones
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

  blocker                     = null_resource.infra_blocker.id
}