variable "slug" {
  description = "The Pivotal Network product slug to install"
}

variable "tile_version" {
  description = "The version of the product to install"
}

variable "glob" {
  description = "The glob of the file to download from Pivotal Network"
  default = ".pivotal"
}

variable "iaas" {
  description = "The IaaS (AWS, GCP etc) for which to download the stemcell"
}

variable "om_product" {
  description = "The name of the product in OpsManager, if it differs from the product slug"
  default     = ""
}

variable "config" {
  description = "The tile configuration yml"
  default     = "---"
}

variable "ops_file" {
  description = "An optional ops file contents that can be applied to the tile configuration"
  default     = "---"
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

variable "blocker" {
  default = ""
}