variable "env_name" {
  description = "Name of the environment"
}

variable "region" {
  description = "Name of the region to deploy to"
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy in"
}

variable "subnet_id" {
  description = "The ID of the subnet to launch in."
}

variable "allowed_hosts" {
  description = "CIDR blocks of trusted networks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "private_ip_address" {
  description = "The private IP address to assign the provisioner instance"
}

variable "instance_type" {
  description = "The type of instance to start."
  default     = "Standard_DS1_v2"
}

variable "disk_size" {
  description = "The size of the root volume in gigabytes."
  default     = 64
}

variable "pivnet_token" {
  description = "Your API token for Pivotal Network"
}

variable "om_host" {
  description = "The OpsManager host to use for API calls"
}

variable "om_username" {
  description = "The username to authenticate with OpsManager API"
  default     = "admin"
}

variable "om_password" {
  description = "The password to authenticate with OpsManager API (randomly generated if not provided)"
  default     = ""
}

variable "secrets" {
  type    = map(string)
  default = {}
}

variable "post_setup_script" {
  description = "Script to run on the provisioner after the core setup script completes"
}

variable "tags" {
  description = "Key/value tags to assign to all resources."
  default     = {}
  type        = map(string)
}

variable "blocker" {
  description = "Used to link to a blocker resource"
  default     = ""
}