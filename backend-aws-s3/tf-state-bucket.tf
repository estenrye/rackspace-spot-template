resource "aws_kms_key" "tf_state_bucket_key" {
  enable_key_rotation = true

  tags = {
    Name    = var.bucket_name
    Project = "terraform-state-storage"
  }
}

#checkov:skip=CKV2_AWS_62:Event notification is not required at this time.
resource "aws_s3_bucket" "tf_state_bucket" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy

  tags = {
    Name    = var.bucket_name
    Project = "terraform-state-storage"
  }
}

resource "aws_s3_bucket_versioning" "tf_state_bucket" {
  bucket = aws_s3_bucket.tf_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "tf_state_bucket" {
  bucket = aws_s3_bucket.tf_state_bucket.id

  target_bucket = aws_s3_bucket.logging_bucket.id
  target_prefix = "${var.bucket_name}/"
}

resource "aws_s3_bucket_public_access_block" "tf_state_bucket_public_access_block" {
  bucket = aws_s3_bucket.tf_state_bucket.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_bucket_sse" {
  bucket = aws_s3_bucket.tf_state_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.tf_state_bucket_key.arn
        sse_algorithm     = "aws:kms"
    }
  }
}
