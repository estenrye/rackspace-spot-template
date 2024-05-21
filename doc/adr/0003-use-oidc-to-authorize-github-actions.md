# 3. Use OIDC to Authorize Github Actions

Date: 2024-05-20

## Status

Accepted

## References

- [AWS Security Blog: Use IAM roles to connect GitHub Actions to AWS](https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/)
- [GitHub Provider](https://registry.terraform.io/providers/integrations/github/latest/docs)
- [GitHub Provider: github_actions_variable](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable)
- [GitHub Provider: github_actions_secret](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret)
- [GitHub CLI: gh auth login](https://cli.github.com/manual/gh_auth_login)
- [GitHub CLI: gh auth token](https://cli.github.com/manual/gh_auth_token)

## Decision

Configure GitHub Actions to use OIDC to authenticate with AWS using Terraform

