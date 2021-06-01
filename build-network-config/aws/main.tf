data "template_file" "subnets" {
  template = chomp(file("${path.module}/templates/subnet-config.yml"))

  count = length(var.subnet_azs)

  vars = {
    id       = "${var.subnet_ids[count.index]}"
    dns      = "${cidrhost(var.vpc_cidr, 2)}"
    cidr     = "${var.subnet_cidrs[count.index]}"
    gateway  = "${cidrhost(var.subnet_cidrs[count.index], 1)}"
    reserved = "${cidrhost(var.subnet_cidrs[count.index], 0)}-${cidrhost(var.subnet_cidrs[count.index], 9)}"
    az       = "${var.subnet_azs[count.index]}"
  }
}

locals {
  subnet_config = "[${join(",", data.template_file.subnets.*.rendered)}]"
}