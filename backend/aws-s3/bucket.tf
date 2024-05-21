resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = var.bucket_name
  force_destroy = var.force_destroy

  tags = {
    Name        = var.bucket_name
    Project     = "terraform-state-storage"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_bucket_sse" {
  bucket = aws_s3_bucket.tf_state_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
    }
  }
}

data "tls_certificate" "github_actions_cert" {
    url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "github_actions_oidc_provider" {
    url = "https://token.actions.githubusercontent.com"

    client_id_list = [
        "sts.amazonaws.com"
    ]

    thumbprint_list = [
        data.tls_certificate.github_actions_cert.certificates.0.sha1_fingerprint
    ]

    tags = {
        Name = "GitHub Actions OIDC Provider"
        Project     = "terraform-state-storage"
    }
}

resource "aws_iam_role" "github_actions_iam_role" {
    name = "GitHubActionsIAMRole"
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Principal = {
                    Federated = aws_iam_openid_connect_provider.github_actions_oidc_provider.arn
                },
                Action = "sts:AssumeRoleWithWebIdentity",
                Condition = {
                    StringEquals = {
                        "${aws_iam_openid_connect_provider.github_actions_oidc_provider.url}:aud" = "sts.amazonaws.com"
                    },
                    StringLike = {
                        "${aws_iam_openid_connect_provider.github_actions_oidc_provider.url}:sub" = "repo:${var.github_orgname}/${var.github_repo}:*"
                    }
                }
            }
        ]
    })

    inline_policy {
        name = "GitHubActionsIAMRolePolicy"
        policy = jsonencode({
            Version = "2012-10-17",
            Statement = [
                {
                    Effect = "Allow",
                    Action = [
                        "s3:GetObject",
                        "s3:PutObject",
                        "s3:ListBucket",
                        "s3:DeleteObject"
                    ],
                    Resource = [
                        aws_s3_bucket.tf_state_bucket.arn,
                        "${aws_s3_bucket.tf_state_bucket.arn}/*"
                    ]
                }
            ]
        })
    }

    tags = {
        Name = "GitHub Actions IAM Role"
        Project     = "terraform-state-storage"
    } 
}

resource "github_actions_variable"  "github_actions_iam_role_arn" {
    repository = var.github_repo
    variable_name = "IAM_ROLE_ARN"
    value = aws_iam_role.github_actions_iam_role.arn
}

resource "github_actions_variable"  "github_actions_aws_region" {
    repository = var.github_repo
    variable_name = "AWS_REGION"
    value = var.aws_region
}

resource "github_actions_variable"  "github_actions_bucket_name" {
    repository = var.github_repo
    variable_name = "TF_VAR_BUCKET_NAME"
    value = var.bucket_name
}

resource "github_actions_secret" "github_actions_rackspace_spot_token" {
    repository = var.github_repo
    secret_name = "RXTSPOT_TOKEN"
    plaintext_value = var.rackspace_spot_token
}