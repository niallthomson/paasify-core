resource "aws_route53_record" "provisioner" {

  depends_on = [aws_instance.provisioner]

  name    = "provisioner"
  zone_id = var.dns_zone_id
  type    = "A"
  ttl     = 30

  records = [
    aws_eip.provisioner.public_ip,
  ]
}