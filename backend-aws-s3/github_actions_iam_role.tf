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
            "${aws_s3_bucket.tf_state_bucket.arn}/*",
          ]
        },
        {
          Effect = "Allow",
          Action = [
            "iam:CreateOpenIDConnectProvider",
            "iam:GetOpenIDConnectProvider",
            "iam:TagOpenIDConnectProvider"
          ],
          Resource = [
            aws_iam_openid_connect_provider.github_actions_oidc_provider.arn
          ]
        },
        {
          Effect = "Allow",
          Action = [
            "kms:CreateKey",
            "kms:TagResource"
          ],
          Resource = ["*"]
        },
        {
          Effect = "Allow",
          Action = [
            "s3:CreateBucket",
            "s3:ListBucket",
            "s3:GetBucketPolicy",
            "s3:GetBucketAcl",
            "s3:GetBucketCors",
            "s3:GetBucketWebsite",
            "s3:GetBucketVersioning",
            "s3express:CreateSession"
          ],
          Resource = [
            aws_s3_bucket.logging_bucket.arn,
            aws_s3_bucket.tf_state_bucket.arn
          ]
        }
      ]
    })
  }

  tags = {
    Name    = "GitHub Actions IAM Role"
    Project = "terraform-state-storage"
  }
}
