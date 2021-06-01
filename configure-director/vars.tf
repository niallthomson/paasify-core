variable "config" {
  description = "Configuration yml for director tile"
}

variable "ops_file" {
  description = "Optional ops file yml for director tile"
  default     = ""
}

// DELETE THIS
variable "vm_extensions" {
  type    = list(string)
  default = []
}

variable "provisioner_host" {
  description = "The host of the paasify provisioner used to trigger the install the tile"
}

variable "provisioner_username" {
  description = "The host of the paasify provisioner used to trigger the install the tile"
}

variable "provisioner_private_key" {
  description = "The SSH private key of the paasify provisioner"
}

variable "bosh_director_ip" {
  description = "The IP address of the BOSH director"
}

variable "blockers" {
  description = "Used to link to a blocker resource"
  default     = []

  type = list(any)
}