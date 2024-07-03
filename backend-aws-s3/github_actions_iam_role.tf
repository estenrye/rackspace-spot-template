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
            aws_s3_bucket.tf_state_bucket.arn
          ]
        },
        {
          Effect = "Allow",
          Action = [
            "iam:CreateOpenIDConnectProvider",
            # "iam:DeleteOpenIDConnectProvider",
            # "iam:GetOpenIDConnectProvider",
            # "iam:UpdateOpenIDConnectProviderThumbprint",
            # "iam:TagOpenIDConnectProvider",
            # "iam:UntagOpenIDConnectProvider"
          ],
          Resource = [
            aws_iam_openid_connect_provider.github_actions_oidc_provider.arn
          ]
        },
        {}
      ]
    })
  }

  tags = {
    Name    = "GitHub Actions IAM Role"
    Project = "terraform-state-storage"
  }
}
