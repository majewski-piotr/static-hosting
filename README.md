
# Static Hosting Infrastructure

This repository provides an infrastructure setup for hosting a static website on AWS using Terraform. It leverages AWS S3 for storage, CloudFront for content delivery, and ACM for SSL certificates.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
  - [Configuration](#configuration)
  - [Deployment](#deployment)
- [Variables](#variables)
- [Outputs](#outputs)
- [License](#license)

## Overview

This project automates the deployment of a static website on AWS. It uses the following AWS services:
- **S3**: Stores the static files.
- **CloudFront**: Serves the content globally with low latency.
- **ACM (AWS Certificate Manager)**: Manages SSL/TLS certificates for HTTPS.

## Architecture

1. **S3 Bucket**: Holds the static files.
2. **CloudFront Distribution**: Distributes the content globally and applies HTTPS using an ACM certificate.
3. **ACM Certificate**: Provides an SSL/TLS certificate for securing the site.

## Prerequisites

Before using this Terraform project, ensure you have the following:
- **Terraform**: Version 1.0.0 or higher.
- **AWS CLI**: Configured with an AWS profile that has necessary permissions.
- **Git**: For cloning the repository.
- **AWS Account**: With appropriate access to create the necessary resources.

## Usage

### Configuration

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/majewski-piotr/static-hosting.git
   cd static-hosting
   ```

2. **Configure Variables:**

   Update the `terraform.tfvars` file with your specific values:

   ```hcl
   name          = "my-static-site"
   domain_name   = "example.com"
   aws_profile   = "my-aws-profile"
   index_document = "index.html"
   repository = {
     url    = "github.com/username/repo"
     token  = "your-access-token"
     branch = "main"
   }
   ```

   Alternatively, set these variables via the command line or an environment variable.

### Deployment

1. **Initialize Terraform:**

   ```bash
   terraform init
   ```

2. **Plan the Deployment:**

   Review the resources that will be created:

   ```bash
   terraform plan
   ```

3. **Apply the Configuration:**

   Deploy the infrastructure:

   ```bash
   terraform apply
   ```

   Type `yes` when prompted to confirm the deployment.

## Variables

Here’s a list of configurable variables for this project:

| Variable        | Type   | Default          | Description                                      |
|-----------------|--------|------------------|--------------------------------------------------|
| `name`          | string | -                | The name of the project or resource.             |
| `domain_name`   | string | -                | The domain name for the CloudFront distribution. |
| `aws_profile`   | string | -                | The AWS CLI profile to use for authentication.   |
| `ttl_max`       | number | 2592000          | Maximum TTL for CloudFront caching (in seconds). |
| `ttl_min`       | number | 86400            | Minimum TTL for CloudFront caching (in seconds). |
| `ttl_default`   | number | 604800           | Default TTL for CloudFront caching (in seconds). |
| `index_document`| string | "index.html"     | The default index document for the S3 bucket.    |
| `repository`    | object | -                | Repository details (URL, token, branch).         |
| `price_class`   | string | "PriceClass_100" | The CloudFront price class to use.               |

## Outputs

After deployment, Terraform provides the following outputs:

| Output                            | Description                                           |
|-----------------------------------|-------------------------------------------------------|
| `acm_certificate_validation_records` | DNS records needed to validate the ACM certificate. |

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.