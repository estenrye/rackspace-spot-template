import {
  to = aws_iam_openid_connect_provider.github_actions_oidc_provider
  id = "arn:aws:iam::673127022430:oidc-provider/token.actions.githubusercontent.com"
}

import {
  to = aws_iam_role.github_actions_iam_role
  id = "GitHubActionsIAMRole"
}

import {
  to = aws_s3_bucket.tf_state_bucket
  id = "tf-state-bucket"
}

import {
  to = aws_kms_key.logging_bucket
  id = "logging-bucket"
}