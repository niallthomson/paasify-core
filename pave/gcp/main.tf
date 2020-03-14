module "infra" {
  source = "../../infra/gcp"

  environment_name = var.environment_name
  region           = var.region
  project          = var.project

  availability_zones  = var.availability_zones
  hosted_zone         = var.hosted_zone
  dns_suffix          = var.dns_suffix
  ops_manager_version = var.ops_manager_version
  ops_manager_build   = var.ops_manager_build
}

resource "null_resource" "infra_blocker" {
  depends_on = [module.infra]
}

module "acme" {
  source = "../../acme/gcp"

  project            = var.project
  opsmanager_domain  = module.infra.ops_manager_domain
  additional_domains = formatlist("%s.${module.infra.base_domain}", var.additional_cert_domains)

  blocker = null_resource.infra_blocker.id
}

module "director_config" {
  source = "../../build-director-config/gcp"

  azs                   = var.availability_zones
  region                = var.region
  project               = var.project
  service_account_email = module.infra.ops_manager_service_account_email

  network_name              = module.infra.network_name
  management_subnet_name    = module.infra.management_subnet_name
  management_subnet_cidr    = module.infra.management_subnet_cidr
  management_subnet_gateway = module.infra.management_subnet_gateway
}

module "provisioner" {
  source = "../../provisioner-instance/gcp"

  availability_zone = var.availability_zones[0]
  env_name          = var.environment_name
  network_name      = module.infra.network_name
  subnet_name       = module.infra.management_subnet_name
  hosted_zone       = module.infra.hosted_zone

  pivnet_token = var.pivnet_token
  om_host      = module.infra.ops_manager_domain

  secrets           = var.secrets
  post_setup_script = var.post_setup_script

  blocker = null_resource.infra_blocker.id
}

resource "null_resource" "provisioner_blocker" {
  depends_on = [module.provisioner]
}

module "configure_director" {
  source = "../../configure-director"

  config           = module.director_config.config
  ops_file         = "${module.director_config.ops_file}\n\n${var.director_ops_file}"
  bosh_director_ip = module.director_config.bosh_director_ip

  provisioner_host        = module.provisioner.public_ip
  provisioner_username    = module.provisioner.ssh_username
  provisioner_private_key = module.provisioner.ssh_private_key

  blockers = concat(list(null_resource.provisioner_blocker.id), var.blockers)
}