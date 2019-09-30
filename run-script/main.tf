resource "null_resource" "script" {
  triggers = {
    script   = var.script
  }

  provisioner "remote-exec" {
    inline = ["echo ${var.blocker}"]
  }

  provisioner "file" {
    content     = var.script
    destination = "~/scripts/${var.name}.sh"
  }

  provisioner "remote-exec" {
    inline = ["wrap bash ~/scripts/${var.name}.sh"]
  }

  connection {
    host        = var.provisioner_host
    user        = var.provisioner_ssh_username
    private_key = var.provisioner_ssh_private_key
  }
}