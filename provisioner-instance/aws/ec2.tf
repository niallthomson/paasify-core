data "aws_ami" "default" {
  most_recent = "true"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

data "aws_subnet" "public" {
  id = local.subnet_id
}

locals {
  vpc_id        = data.aws_subnet.public.vpc_id
  env_name      = var.env_name
  ami_id        = data.aws_ami.default.id
  disk_size     = var.disk_size
  subnet_id     = var.subnet_id
  instance_type = var.instance_type
  username      = "ubuntu"
}

resource "aws_eip" "provisioner" {
  vpc      = true
  instance = aws_instance.provisioner.id
}

resource "aws_instance" "provisioner" {
  ami                         = local.ami_id
  instance_type               = local.instance_type
  key_name                    = aws_key_pair.provisioner.key_name
  subnet_id                   = local.subnet_id
  vpc_security_group_ids      = [aws_security_group.provisioner.id]

  root_block_device {
    volume_size           = local.disk_size
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [ami]
  }

  tags = {
    Name    = "paasify-provisioner-${local.env_name}"
  }
}