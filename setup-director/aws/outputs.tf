output "dns" {
  value = module.provisioner.dns
}

output "ssh_username" {
  value = module.provisioner.ssh_username
}

output "ssh_private_key" {
  value = module.provisioner.ssh_private_key
}