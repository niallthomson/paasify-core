resource "null_resource" "setup" {

  triggers = {
    instance_id = aws_instance.provisioner.id
  }

  provisioner "file" {
    source      = "${path.module}/scripts/provision.sh"
    destination = "/tmp/provision.sh"
  }

  provisioner "remote-exec" {
    inline = ["echo ${var.blocker}", "mkdir -p /tmp/scripts-upload"]
  }

  provisioner "file" {
    source      = "${path.module}/scripts/util/"
    destination = "/tmp/scripts-upload"
  }

  provisioner "remote-exec" {
    inline = ["chmod +x /tmp/provision.sh && /tmp/provision.sh ${var.pivnet_token} ${var.om_host} ${var.om_username} ${local.om_password}"]
  }

  connection {
    host        = aws_eip.provisioner.public_ip
    user        = local.username
    private_key = tls_private_key.provisioner.private_key_pem
  }
}