variable "instance_id" {
  description = "The ID of the instance being provisioned, used to trigger a re-apply"
}

variable "host" {
  description = "The host to setup"
}

variable "username" {
  description = "The SSH username for the instance"
}

variable "private_key" {
  description = "The SSH private key for the instance"
}

variable "pivnet_token" {
  description = "Your API token for Pivotal Network"
}

variable "om_host" {
  description = "The OpsManager host to use for API calls"
}

variable "om_username" {
  description = "The username to authenticate with OpsManager API"
}

variable "om_password" {
  description = "The password to authenticate with OpsManager API"
}

variable "post_setup_script" {
  description = "Script to run after the core setup script completes"
}

variable "blocker" {
}