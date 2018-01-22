#  LAMP Stack for AWS

The infrastructure of a good old LAMP stack is used to explain 
how a minimal Terraform project looks like in practice.

<p>
 <img src="img/lamp.png" alt="LAMP Stack architecture">   
 <em>Figure 1: LAMP Stack architecture</em>
</p>

## Requirements

* AWS Account (free tier)
* aws-cli 1.10.33
* Packer v0.12.3
* Terraform v0.10.0
* librarian-chef 0.0.4

## Getting started

[Create a profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html) for your AWS account:

1. `aws configure --profile myaccount set aws_access_key_id YOUR_AWS_ACCESS_KEY_ID`
2. `aws configure --profile myaccount set aws_secret_access_key YOUR_AWS_SECRET_ACCESS_KEY`
3. `aws --profile myaccount configure set region us-west-2`

## Packer

To create the webservers for the LAMP stack (orange boxes in Fig. 1), we use [Packer](https://www.packer.io):

```
cd packer/
librarian-chef install
./build_amis.sh myaccount 1
```

Packer first launches an EC2 instance, then installs apache2 and php on it, and finally saves
a snapshot of that provisioned instance as an Amazon machine image (AMI). 
This Packer details are configured in the [lamp.json](packer/lamp.json).

 
The AMI can be used to spin up several webservers of the exact same kind. 
This is less error-prone (single point of testing) and faster in scaling than 
provisioning each single EC2 instance after launching it.

## Terraform

Create infrastructure of the LAMP Stack in the cloud:

```
cd terraform/
terraform init
terraform get
terraform apply \
    -var profile=myaccount \
    -var region="us-west-2" 
```

Destroy infrastructure completely:

```
cd terraform/
terraform destroy \
    -var profile=myaccount \
    -var region="us-west-2"
```
