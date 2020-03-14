module "infra" {
  source = "../../infra/azure"

  environment_name = var.environment_name
  region           = var.region

  dns_suffix          = var.dns_suffix
  ops_manager_version = var.ops_manager_version
  ops_manager_build   = var.ops_manager_build
}

resource "null_resource" "infra_blocker" {
  depends_on = [module.infra]
}

module "acme" {
  source = "../../acme/azure"

  opsmanager_domain  = module.infra.ops_manager_domain
  additional_domains = formatlist("%s.${module.infra.base_domain}", var.additional_cert_domains)

  subscription_id     = var.subscription_id
  tenant_id           = var.tenant_id
  client_id           = var.client_id
  client_secret       = var.client_secret
  resource_group_name = module.infra.resource_group_name

  blocker = null_resource.infra_blocker.id
}

module "director_config" {
  source = "../../build-director-config/azure"

  ssh_public_key            = module.infra.ops_manager_ssh_public_key
  ssh_private_key           = module.infra.ops_manager_ssh_private_key
  region                    = var.region
  azs                       = var.availability_zones
  bosh_storage_account_name = module.infra.bosh_storage_account_name

  subscription_id     = var.subscription_id
  tenant_id           = var.tenant_id
  client_id           = var.client_id
  client_secret       = var.client_secret
  resource_group_name = module.infra.resource_group_name

  network_name              = module.infra.network_name
  management_subnet_name    = module.infra.management_subnet_name
  management_subnet_cidr    = module.infra.management_subnet_cidr
  management_subnet_gateway = module.infra.management_subnet_gateway
}

module "provisioner" {
  source = "../../provisioner-instance/azure"

  env_name            = var.environment_name
  region              = var.region
  resource_group_name = module.infra.resource_group_name
  subnet_id           = module.infra.management_subnet_id
  private_ip_address  = cidrhost(module.infra.management_subnet_cidr, 5)

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