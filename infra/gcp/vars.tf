variable "project" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "region" {
  type = string
}

variable "hosted_zone" {
  description = "Hosted zone name (e.g. foo is the zone name and foo.example.com is the DNS name)."
}

variable "dns_suffix" {
  description = "DNS suffix to add domains to (e.g. foo.example.com)"
  type        = string
}

variable "availability_zones" {
  description = "Requires exactly THREE availability zones that must belong to the provided region."
  type        = list(any)
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type    = string
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
  default = "n1-standard-2"
  type    = string
}

variable "ops_man_image_creation_timeout" {
  type    = string
  default = "10m"
}