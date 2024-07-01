resource "aws_kms_key" "logging_bucket" {
  enable_key_rotation = true

  tags = {
    Name    = "s3-access-logs-key"
    Project = "audit-logging"
  }
}

resource "aws_s3_bucket" "logging_bucket" {
  bucket        = "s3-access-logs"
  force_destroy = var.force_destroy
  
  ##tfsec:ignore:aws-s3-enable-bucket-logging

  tags = {
    Name    = "s3-access-logs"
    Project = "terraform-state-storage"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.logging_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "logging_bucket" {
  bucket = aws_s3_bucket.logging_bucket.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logging_bucket" {
  bucket = aws_s3_bucket.logging_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.logging_bucket.arn
        sse_algorithm     = "aws:kms"
    }
  }
}