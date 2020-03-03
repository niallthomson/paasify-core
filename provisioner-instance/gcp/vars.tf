variable "env_name" {
  description = "Name of the environment"
}

variable "availability_zone" {
  description = "The AZ to deploy in"
}

variable "network_name" {
  description = "The network to launch in."
}

variable "subnet_name" {
  description = "The network to launch in."
}

variable "allowed_hosts" {
  description = "CIDR blocks of trusted networks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "instance_type" {
  description = "The type of instance to start."
  default     = "n1-standard-2"
}

variable "disk_size" {
  description = "The size of the root volume in gigabytes."
  default     = 64
}

variable "hosted_zone" {
  description = "The hosted zone to place the DNS record"
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

variable "blocker" {
  description = "Used to link to a blocker resource"
  default     = ""
}