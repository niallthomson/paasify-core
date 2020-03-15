resource "aws_iam_instance_profile" "provisioner_profile" {
  name = "paasify-${var.env_name}-provisioner"
  role = aws_iam_role.provisioner.name
}

resource "aws_iam_role" "provisioner" {
  name = "paasify-${var.env_name}-provisioner"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "provisioner_policy" {
  name = "paasify-${var.env_name}-provisioner"
  role = aws_iam_role.provisioner.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ElasticRuntimeKMSPermissions1",
      "Effect": "Allow",
      "Action": [
        "kms:Decrypt",
        "kms:Encrypt",
        "kms:DescribeKey"
      ],
      "Resource": "${aws_kms_key.secrets_bucket_key.arn}"
    },
    {
      "Sid": "ElasticRuntimeKMSPermissions2",
      "Effect": "Allow",
      "Action": "kms:GenerateDataKey",
      "Resource": "*"
    },
    {
      "Sid": "Ec2Permissions",
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeAddresses",
        "ec2:AssociateAddress",
        "ec2:DisassociateAddress",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeImages",
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
        "ec2:DescribeInternetGateways",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcs",
        "ec2:CreateTags",
        "ec2:DescribeVolumes",
        "ec2:CreateVolume",
        "ec2:AttachVolume",
        "ec2:DeleteVolume",
        "ec2:DetachVolume",
        "ec2:CopyImage",
        "ec2:CopySnapshot"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "LBPermissions",
      "Effect": "Allow",
      "Action": [
        "elasticloadbalancing:CreateLoadBalancer",
        "elasticloadbalancing:CreateTargetGroup",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:DescribeTargetHealth",
        "elasticloadbalancing:RegisterTargets",
        "elasticloadbalancing:SetIpAddressType",
        "elasticloadbalancing:SetSubnets"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}