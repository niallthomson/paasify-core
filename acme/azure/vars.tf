variable "client_id" {}

variable "client_secret" {}

variable "tenant_id" {}

variable "subscription_id" {}

variable "resource_group_name" {}

variable "opsmanager_domain" {

}

variable "additional_domains" {
  type    = list(string)
  default = []
}

variable "blocker" {}