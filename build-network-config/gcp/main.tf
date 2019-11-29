data "template_file" "subnet" {
  template = "${chomp(file("${path.module}/templates/subnet-config.yml"))}"

  vars = {
    id       = "${var.network_name}/${var.subnet_name}/${var.region}"
    dns      = "169.254.169.254"
    cidr     = var.subnet_cidr
    gateway  = cidrhost(var.subnet_cidr, 1)
    reserved = "${cidrhost(var.subnet_cidr, 0) }-${cidrhost(var.subnet_cidr, 9)}"
    az       = join(", ", var.subnet_azs)
  }
}

locals {
  subnet_config = data.template_file.subnet.rendered
}