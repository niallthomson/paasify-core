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