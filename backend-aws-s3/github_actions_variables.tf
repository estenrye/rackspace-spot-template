resource "github_actions_variable" "github_actions_iam_role_arn" {
  repository    = var.github_repo
  variable_name = "IAM_ROLE_ARN"
  value         = aws_iam_role.github_actions_iam_role.arn
}

resource "github_actions_variable" "github_actions_aws_region" {
  repository    = var.github_repo
  variable_name = "AWS_REGION"
  value         = var.aws_region
}

resource "github_actions_variable" "github_actions_bucket_name" {
  repository    = var.github_repo
  variable_name = "TF_VAR_BUCKET_NAME"
  value         = var.bucket_name
}