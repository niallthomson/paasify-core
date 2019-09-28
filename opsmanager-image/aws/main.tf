data "aws_ami" "ami" {
  most_recent      = true

  filter {
    name   = "name"
    values = ["pivotal-ops-manager-v${var.om_version}-build.${var.om_build}"]
  }

  owners = ["364390758643"]
}