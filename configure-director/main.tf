resource "null_resource" "setup_director" {

  provisioner "remote-exec" {
    inline = ["echo ${sha256(join("", var.blockers))}"]
  }

  provisioner "file" {
    content     = var.config
    destination = "~/config/opsman-config.yml"
  }

  provisioner "file" {
    content     = var.ops_file
    destination = "~/config/opsman-config-ops.yml"
  }

  provisioner "file" {
    content     = length(var.vm_extensions) > 0 ? join("\n|\n", var.vm_extensions) : " "
    destination = "~/vm_extensions.txt"
  }

  provisioner "remote-exec" {
    inline = ["wrap configure_opsman"]
  }

  // Convert this in to a script on provisioner
  // Or something that hooks in to apply-changes
  /*provisioner "remote-exec" {
    inline = ["wrap post_install_opsman ${var.bosh_director_ip}"]
  }*/

  connection {
    host        = var.provisioner_host
    user        = var.provisioner_username
    private_key = var.provisioner_private_key
  }
}