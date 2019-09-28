resource "aws_security_group" "provisioner" {
  name        = "paasify-provisioner-sg-${local.env_name}"
  description = "Allow SSH access to provisioner host and outbound internet access"
  vpc_id      = local.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "ssh" {
  protocol          = "TCP"
  from_port         = 22
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = var.allowed_hosts
  security_group_id = aws_security_group.provisioner.id
}

resource "aws_security_group_rule" "internet" {
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.provisioner.id
}