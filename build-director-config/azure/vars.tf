variable "azs" {
  type = list(string)
}

variable "network_name" {}
variable "management_subnet_name" {}
variable "management_subnet_cidr" {}
variable "management_subnet_gateway" {}
variable "region" {}

variable "client_id" {}

variable "client_secret" {}

variable "tenant_id" {}

variable "subscription_id" {}

variable "resource_group_name" {}

variable "bosh_storage_account_name" {}

variable "ssh_private_key" {}

variable "ssh_public_key" {}