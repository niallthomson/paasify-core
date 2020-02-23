variable "azs" {
  type = list(string)
}

variable "network_name" {} 
variable "management_subnet_name" {} 
variable "management_subnet_cidr" {}
variable "management_subnet_gateway" {}
variable "region" {} 
variable "project" {}
variable "service_account_email" {}