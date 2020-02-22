resource "null_resource" "setup" {

  triggers = {
    instance_id = var.instance_id
  }

  provisioner "file" {
    source      = "${path.module}/scripts/provision.sh"
    destination = "/home/ubuntu/provision.sh"
  }

  provisioner "remote-exec" {
    inline = ["echo ${var.blocker}", "mkdir -p /tmp/scripts-upload"]
  }

  provisioner "file" {
    source      = "${path.module}/scripts/util/"
    destination = "/tmp/scripts-upload"
  }

  provisioner "remote-exec" {
    inline = ["chmod +x /home/ubuntu/provision.sh && /home/ubuntu/provision.sh ${var.pivnet_token} ${var.om_host} ${var.om_username} ${var.om_password}"]
  }

  connection {
    host        = var.host
    user        = var.username
    private_key = var.private_key
  }
}