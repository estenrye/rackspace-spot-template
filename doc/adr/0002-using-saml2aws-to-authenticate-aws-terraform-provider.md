# 2. Using saml2aws to Authenticate AWS Terraform Provider

Date: 2024-05-20

## Status

Accepted

## References

- [Accessing the AWS CLI Using saml2aws](https://curc.readthedocs.io/en/latest/cloud/aws/getting-started/aws-cli-saml2aws.html)


## Procedure

1. Configure saml2aws with the AWS SSO URL and the AWS SSO profile.

    ```bash
    saml2aws configure
    ```

2. Authenticate with AWS SSO.

    ```bash
    saml2aws login
    ```

## Consequences


Access to AWS resources is now authenticated using saml2aws. This allows for easier management of AWS credentials and access to AWS resources using the AWS CLI and Terraform provider through the use of AWS Profiles.