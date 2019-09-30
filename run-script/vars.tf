variable "name" {
  description = "The name of the script to be executed on the provisioner with bash"
}

variable "script" {
  description = "The script contents to be executed on the provisioner with bash"
}

variable "provisioner_host" {
  description = "The host of the paasify provisioner used to trigger the install the tile"
}

variable "provisioner_ssh_username" {
  description = "The host of the paasify provisioner used to trigger the install the tile"
}

variable "provisioner_ssh_private_key" {
  description = "The SSH private key of the paasify provisioner"
}

variable "blocker" {
  default = ""
}