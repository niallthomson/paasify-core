locals {
  om_password = var.om_password == "" ? random_string.opsman_password.result : var.om_password
}

resource "random_string" "opsman_password" {
  length  = 8
  special = false
}