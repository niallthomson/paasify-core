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
  type        = list(any)
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type    = string
}

variable "ops_manager_allowed_ips" {
  description = "IPs allowed to communicate with Ops Manager."
  default     = ["0.0.0.0/0"]
  type        = list(any)
}

variable "tags" {
  description = "Key/value tags to assign to all resources."
  default     = {}
  type        = map(string)
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

variable "additional_iam_roles_arn" {
  type    = list(any)
  default = []
}

variable "ssl_cert" {

}

variable "ssl_private_key" {
  
}