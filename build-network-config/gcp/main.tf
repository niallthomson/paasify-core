data "template_file" "subnet" {
  template = "${chomp(file("${path.module}/templates/subnet-config.yml"))}"

  vars = {
    id       = "${var.network_name}/${var.subnet_name}/${var.region}"
    dns      = "169.254.169.254"
    cidr     = var.subnet_cidr
    gateway  = var.subnet_gateway
    reserved = "${cidrhost(var.subnet_cidr, 0)}-${cidrhost(var.subnet_cidr, 9)}"
    azs      = join(", ", var.subnet_azs)
  }
}

locals {
  subnet_config = data.template_file.subnet.rendered
}