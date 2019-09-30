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

resource "aws_iam_role_policy" "test_policy" {
  name = "paasify-${var.env_name}-provisioner"
  role = aws_iam_role.provisioner.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ElasticRuntimeS3Permissions",
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${aws_s3_bucket.secrets_bucket.arn}",
        "${aws_s3_bucket.secrets_bucket.arn}/*"
      ]
    },
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
    }
  ]
}
EOF
}