resource "aws_kms_key" "logging_bucket" {
  enable_key_rotation = true

  tags = {
    Name    = "s3-access-logs-key"
    Project = "audit-logging"
  }
}

#tfsec:ignore:aws-s3-enable-bucket-logging
#checkov:skip=CKV2_AWS_62:Event notification is not required at this time.
resource "aws_s3_bucket" "logging_bucket" {
  bucket        = "s3-access-logs"
  force_destroy = var.force_destroy
  

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

resource "aws_s3_bucket_policy" "logging_bucket" {
  bucket = aws_s3_bucket.logging_bucket.bucket
  policy = data.aws_iam_policy_document.s3_access_logging_bucket_policy.json
}

data "aws_iam_policy_document" "s3_access_logging_bucket_policy" {
  statement {
    sid = "S3ServerAccessLogsPolicy"
    effect = "Allow"

    actions = [
      "s3:PutObject"
    ]

    principals {
      type       = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }

    resources = [
      "${aws_s3_bucket.logging_bucket.arn}/${var.bucket_name}/*"
    ]

    condition {
        test     = "ArnLike"
        variable = "aws:SourceArn"
        values   = [
            "arn:aws:s3:::${var.bucket_name}"
        ]
    }

    condition {
        test     = "StringEquals"
        variable = "aws:SourceAccount"
        values   = [
            data.aws_caller_identity.current.account_id
        ]
    }
  }
}
