resource "null_resource" "apply_common" {
  provisioner "remote-exec" {
    inline = ["apply_changes ${var.blocker}"]
  }

  count = "${var.run ? 1 : 0}"

  connection {
    host        = var.provisioner_host
    user        = var.provisioner_ssh_username
    private_key = var.provisioner_ssh_private_key
  }
}