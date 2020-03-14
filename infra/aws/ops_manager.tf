resource "aws_key_pair" "ops_manager" {
  key_name   = "${var.environment_name}-ops-manager-key"
  public_key = tls_private_key.ops_manager.public_key_openssh
}

resource "tls_private_key" "ops_manager" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "aws_iam_access_key" "ops_manager" {
  user = aws_iam_user.ops_manager.name
}

resource "aws_iam_policy" "ops_manager_role" {
  name   = "${var.environment_name}-ops-manager-role"
  policy = data.aws_iam_policy_document.ops_manager.json
}

resource "aws_iam_role_policy_attachment" "ops_manager_policy" {
  role       = aws_iam_role.ops_manager.name
  policy_arn = aws_iam_policy.ops_manager_role.arn
}

resource "aws_iam_role" "ops_manager" {
  name = "${var.environment_name}-ops-manager-role"

  lifecycle {
    create_before_destroy = true
  }

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": [
        "sts:AssumeRole"
      ]
    }
  ]
}
EOF

}

resource "aws_iam_instance_profile" "ops_manager" {
  name = "${var.environment_name}-ops-manager"
  role = aws_iam_role.ops_manager.name

  lifecycle {
    ignore_changes = [name]
  }
}

resource "aws_iam_user" "ops_manager" {
  force_destroy = true
  name          = "${var.environment_name}-ops-manager"
}

resource "aws_iam_user_policy" "ops_manager" {
  name   = "${var.environment_name}-ops-manager-policy"
  user   = aws_iam_user.ops_manager.name
  policy = data.aws_iam_policy_document.ops_manager.json
}

data "aws_iam_policy_document" "ops_manager" {
  statement {
    sid       = "OpsMgrInfoAboutCurrentInstanceProfile"
    effect    = "Allow"
    actions   = ["iam:GetInstanceProfile"]
    resources = [aws_iam_instance_profile.ops_manager.arn]
  }

  statement {
    sid       = "OpsMgrCreateInstanceWithCurrentInstanceProfile"
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = concat([aws_iam_role.ops_manager.arn], var.additional_iam_roles_arn)
  }

  statement {
    sid     = "OpsMgrS3Permissions"
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.ops_manager_bucket.arn,
      "${aws_s3_bucket.ops_manager_bucket.arn}/*"
    ]
  }

  statement {
    sid    = "OpsMgrEC2Permissions"
    effect = "Allow"
    actions = [
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:AssociateAddress",
      "ec2:DisassociateAddress",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeImages",
      "ec2:DeregisterImage",
      "ec2:DescribeInstances",
      "ec2:RunInstances",
      "ec2:RebootInstances",
      "ec2:TerminateInstances",
      "ec2:DescribeKeypairs",
      "ec2:DescribeRegions",
      "ec2:DescribeSnapshots",
      "ec2:CreateSnapshot",
      "ec2:DeleteSnapshot",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs",
      "ec2:CreateTags",
      "ec2:DescribeVolumes",
      "ec2:CreateVolume",
      "ec2:AttachVolume",
      "ec2:DeleteVolume",
      "ec2:DetachVolume",
      "ec2:CopyImage",
      "ec2:CopySnapshot",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:RegisterTargets"
    ]
    resources = ["*"]
  }
}

data "aws_ami" "ami" {
  owners      = ["364390758643"]
  most_recent = true

  filter {
    name   = "name"
    values = ["pivotal-ops-manager-v${var.ops_manager_version}-build.${var.ops_manager_build}"]
  }
}

resource "aws_instance" "ops_manager" {
  ami                    = data.aws_ami.ami.id
  instance_type          = var.ops_manager_instance_type
  key_name               = aws_key_pair.ops_manager.key_name
  vpc_security_group_ids = ["${aws_security_group.ops_manager.id}"]
  source_dest_check      = false
  subnet_id              = element(aws_subnet.public_subnet.*.id, 0)
  iam_instance_profile   = aws_iam_instance_profile.ops_manager.name

  root_block_device {
    volume_type = "gp2"
    volume_size = 150
  }

  tags = merge(var.tags, map("Name", "${var.environment_name}-ops-manager"))
}

resource "aws_eip" "ops_manager" {
  vpc      = true
  instance = aws_instance.ops_manager.id

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-ops-manager-eip" },
  )

  connection {
    host        = self.public_ip
    user        = "ubuntu"
    private_key = tls_private_key.ops_manager.private_key_pem
  }

  // Use this to make sure OpsManager is given time to boot before subsequent modules proceed
  provisioner "remote-exec" {
    inline = [
      "date",
    ]
  }
}