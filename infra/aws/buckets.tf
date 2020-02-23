resource "random_integer" "bucket_suffix" {
  min = 1
  max = 100000
}

resource "aws_s3_bucket" "ops_manager_bucket" {
  bucket        = "${var.environment_name}-ops-manager-bucket-${random_integer.bucket_suffix.result}"
  force_destroy = true

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-ops-manager-bucket-${random_integer.bucket_suffix.result}" },
  )
}