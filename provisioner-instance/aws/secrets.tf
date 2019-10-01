resource "random_string" "secret_bucket_suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "aws_kms_key" "secrets_bucket_key" {
  description             = "paasify-${var.env_name}-secrets-bucket-${random_string.secret_bucket_suffix.result}"
  deletion_window_in_days = 7
}

resource "aws_s3_bucket" "secrets_bucket" {
  bucket = "paasify-${var.env_name}-secrets"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.secrets_bucket_key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket_object" "secrets" {
  bucket  = aws_s3_bucket.secrets_bucket.bucket
  key     = "secrets.json"
  content = jsonencode(var.secrets)
}