output "config" {
  value = data.template_file.director_configuration.rendered
}