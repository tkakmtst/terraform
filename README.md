# Terraform

## Setup

### Install terraform

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

https://developer.hashicorp.com/terraform/install

### Install aws-cli

```bash
$ brew install awscli
```

### Set AWS Configure

AWS Management Console から IAM User の発行と、アクセスキーを発行する

```bash
$ aws configure

AWS Access Key ID [None]: <access_key>
AWS Secret Access Key [None]: <secret_key>
Default region name [None]: ap-northeast-1
Default output format [None]: json
```

### Apply Resources

```bash
$ cd aws/envs/stg
$ terraform init
$ terrafrom plan
$ terraform apply
```

## Docs

https://developer.hashicorp.com/terraform?product_intent=terraform
