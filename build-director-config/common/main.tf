data "template_file" "director_configuration" {
  template = "${chomp(file("${path.module}/templates/director_config.yml"))}"

  vars = {
    az  = var.director_az
    ntp = var.ntp
  }
}