resource "null_resource" "apply_changes" {
  triggers = {
    blocker = var.blocker
  }

  provisioner "remote-exec" {
    inline = ["wrap apply_changes ${var.blocker}"]
  }

  connection {
    host        = var.provisioner_host
    user        = var.provisioner_ssh_username
    private_key = var.provisioner_ssh_private_key
  }
}