output "public_ip" {
  value = aws_instance.provisioner.public_ip
}

output "private_ip" {
  value = aws_instance.provisioner.private_ip
}

output "instance_id" {
  value = aws_instance.provisioner.id
}

output "keypair_name" {
  value = aws_key_pair.provisioner.key_name
}

output "dns" {
  value = aws_route53_record.provisioner.fqdn
}

output "ssh_username" {
  value = local.username
}

output "ssh_public_key" {
  value = aws_key_pair.provisioner.public_key
}

output "ssh_private_key" {
  value = tls_private_key.provisioner.private_key_pem
}

output "om_host" {
  value = var.om_host
}

output "om_username" {
  value = var.om_username
}

output "om_password" {
  value = local.om_password
}

output "blocker" {
  value = null_resource.setup.id
}