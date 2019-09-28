variable "dns_zone_id" {

}

variable "opsmanager_domain" {

}

variable "additional_domains" {
  type = list(string)
  default = []
}