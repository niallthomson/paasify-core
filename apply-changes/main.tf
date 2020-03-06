resource "null_resource" "destroy" {
  count = var.auto_apply ? 1 : 0

  provisioner "remote-exec" {
    inline = ["echo ${var.blocker}"]
  }

  provisioner "remote-exec" {
    when = destroy

    inline = ["wrap destroy_opsman"]
  }

  connection {
    host        = var.provisioner_host
    user        = var.provisioner_ssh_username
    private_key = var.provisioner_ssh_private_key
  }
}

resource "null_resource" "apply_changes" {
  count = var.auto_apply ? 1 : 0

  triggers = {
    blocker = var.blocker
  }

  provisioner "remote-exec" {
    inline = ["wrap apply_changes ${null_resource.destroy.id}"]
  }

  connection {
    host        = var.provisioner_host
    user        = var.provisioner_ssh_username
    private_key = var.provisioner_ssh_private_key
  }
}