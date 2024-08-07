# Rackspace Spot TF Template

This repository contains a Terraform template for provisioning resources on Rackspace Spot instances.

## Table of Contents

- [Introduction](#introduction)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

The Rackspace Spot TF Template provides a convenient way to provision resources on Rackspace Spot instances using Terraform. It includes pre-configured modules and examples to help you get started quickly.

## Configuring the saml2aws idp account for the terraform S3 backend.

```bash
saml2aws configure \
  --idp-account=ryezone-labs \
  --idp-provider=JumpCloud \
  --mfa=WEBAUTHN \
  --profile=ryezone-labs \
  --url=https://sso.jumpcloud.com/saml2/aws-rzlbs \
  --cache-saml
```

## Logging into saml2aws for the terraform S3 backend.

```bash
saml2aws login \
  --idp-account=ryezone-labs \
  --profile=ryezone-labs
```

## Running Tasks Locally

```bash
export AWS_PROFILE=ryezone-labs
export AWS_REGION=us-east-2
export TF_VAR_BUCKET_NAME=tf-cloudspace-bucket
```

## Getting Started

To get started with this template, follow these steps:

1. Click the "Use this template" button to create a new repository based on this template.
2. Provide a a name and description for the new repository.
3. Choose whether to make the repository public or private.
4. Click the "Create repository from template" button to create the new repository.
5. Click the "Settings" tab in the new repository.
6. Click the "Secrets and variables" link in the sidebar.
7. Click the "Actions" link in the sidebar.
8. Create a new repository secret with the name `RXTSPOT_TOKEN` and the value of your Rackspace Terraform API token.
9. Clone the new repository to your local machine.
10. Install Devbox

    ```bash
    curl -fsSL https://get.jetify.com/devbox | bash
    ```
11. Launch Devbox

    ```bash
    devbox shell
    ```
12. Create a new cloudspace
    ```bash
    task new-cloudspace
    ```

## Usage

TBD

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

This repository is licensed under the [MIT License](LICENSE).