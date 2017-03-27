# Demo: A LAMP Stack for AWS

## Requirements

* AWS Account (free tier)
* Packer v0.12.3
* Terraform v0.8.5

## Getting started

1. `aws configure --profile lamp set aws_access_key_id YOUR_AWS_ACCESS_KEY_ID`
2. `aws configure --profile lamp set aws_secret_access_key YOUR_AWS_SECRET_ACCESS_KEY`
3. `aws --profile lamp configure set region us-west-2`

## Packer

```
cd packer/
librarian-chef install
./build_amis.sh 1
```

## Terraform

Create LAMP Stack:

```
cd terraform/
terraform apply
```

Tear LAMP Stack down:

```
cd terraform/
terraform destroy
```
