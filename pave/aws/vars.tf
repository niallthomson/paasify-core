variable "environment_name" {
  type = string
}

variable "region" {
  type = string
}

variable "dns_suffix" {
  description = "DNS suffix to add domains to (e.g. foo.example.com)"
  type        = string
}

variable "availability_zones" {
  description = "The list of availability zones to use. Must belong to the provided region and equal the number of CIDRs provided for each subnet."
  type        = list
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type    = string
}

variable "ops_manager_version" {
  type = string
}

variable "ops_manager_build" {
  type = string
}

variable "ops_manager_instance_type" {
  default = "r4.large"
  type    = string
}

variable "pivnet_token" {
  description = "Your API token for Pivotal Network"
  type        = string
}

variable "director_ops_file" {
  description = "Optional ops file yml for director tile"
  default     = ""
}

variable "secrets" {
  type    = map(string)
  default = {}
}

variable "additional_cert_domains" {
  type    = list(string)
  default = []
}

variable "blockers" {
  description = "Used to link to a blocker resource"
  default     = []

  type = list
}