resource "aws_key_pair" "provisioner" {
  key_name   = "paasify-provisioner-key-${local.env_name}"
  public_key = tls_private_key.provisioner.public_key_openssh
}

resource "tls_private_key" "provisioner" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}