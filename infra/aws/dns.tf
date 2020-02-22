data "aws_route53_zone" "selected" {
  name = var.dns_suffix
}

locals {
  base_domain = "${var.environment_name}.${var.dns_suffix}"
  om_domain   = "opsmanager.${local.base_domain}"
}

resource "aws_route53_zone" "zone" {
  name = local.base_domain
}

resource "aws_route53_record" "ns" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = local.base_domain
  type    = "NS"
  ttl     = "30"

  records = aws_route53_zone.zone.name_servers
}

resource "aws_route53_record" "ops-manager" {
  name = local.om_domain

  zone_id = aws_route53_zone.zone.zone_id
  type    = "A"
  ttl     = 300

  records = [aws_eip.ops_manager.public_ip]
}