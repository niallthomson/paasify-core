resource "null_resource" "provision_opsman" {

  provisioner "local-exec" {
    command = "sleep 60"
  }

  provisioner "file" {
    content     = var.ssl_cert
    destination = "/tmp/tempest.crt"
  }

  provisioner "file" {
    content     = var.ssl_private_key
    destination = "/tmp/tempest.key"
  }

  provisioner "file" {
    source      = "${path.module}/scripts/"
    destination = "/home/ubuntu"
  }

  provisioner "remote-exec" {
    inline = ["chmod +x /home/ubuntu/provision_opsman.sh && /home/ubuntu/provision_opsman.sh"]
  }

  connection {
    host        = var.ops_manager_domain
    user        = "ubuntu"
    private_key = var.ops_manager_ssh_private_key
  }
}