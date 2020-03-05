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

variable "vpc_cidr" {
  default = "10.0.0.0/20"
  type    = string
}

variable "ops_manager_allowed_ips" {
  description = "IPs allowed to communicate with Ops Manager."
  default     = ["0.0.0.0/0"]
  type        = list
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
  default = "Standard_DS2_v2"
  type    = string
}