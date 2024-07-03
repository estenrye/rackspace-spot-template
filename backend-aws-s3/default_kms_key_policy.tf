data "aws_iam_policy_document" "default_kms_key_policy" {
  statement {
    sid    = "DefaultAllowKeyAdministration"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    resources = ["*"]
    actions   = ["kms:*"]
  }
}
