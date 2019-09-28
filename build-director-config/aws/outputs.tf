output "config" {
  value = module.common.config
}

output "ops_file" {
  value = data.template_file.director_configuration.rendered
}

output "bosh_director_ip" {
  value = cidrhost(var.management_subnet_cidrs[0], 10)
}

output "az_configuration" {
  value = "[${join(", ", formatlist("{name: %s}", var.azs))}]"
}