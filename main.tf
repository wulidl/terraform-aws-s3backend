data "aws_kms_key" "s3" {
  key_id = "alias/aws/s3"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket        = "state-bucket-${var.namespace}"
  force_destroy = var.force_destroy_state
  acl           = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = data.aws_kms_key.s3.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

}


resource "aws_s3_bucket_public_access_block" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "state-lock-${var.namespace}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  billing_mod    = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}
