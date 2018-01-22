#  LAMP Stack for AWS

The infrastructure of a good old LAMP stack is used to explain 
how a minimal Terraform project looks like in practice.

<p>
 <img src="img/lamp.png" alt="LAMP Stack architecture">   
 <em>Figure 1: LAMP Stack architecture</em>
</p>

## Requirements

* AWS Account (there is [free tier](https://aws.amazon.com/free/) if you don't have an account yet)
* aws-cli 1.10.33
* Packer v0.12.3
* Terraform v0.10.0
* librarian-chef 0.0.4

## Getting started

[Create a profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html) for your AWS account:

1. `aws configure --profile myaccount set aws_access_key_id YOUR_AWS_ACCESS_KEY_ID`
2. `aws configure --profile myaccount set aws_secret_access_key YOUR_AWS_SECRET_ACCESS_KEY`
3. `aws --profile myaccount configure set region us-west-2`

## Bring up LAMP stack

We use Packer and Terraform to do so! 

It takes only 2 "steps" to create the complete LAMP stack.

### Provision webservers

To create the webservers for the LAMP stack (orange boxes in Fig. 1), we use [Packer](https://www.packer.io):

```
cd packer/
librarian-chef install
./build_amis.sh myaccount 1
```

Packer first launches an EC2 instance, then installs apache2 and PHP on it, and finally saves
a snapshot of that provisioned instance as an Amazon machine image (AMI). 
This Packer details are configured in the [lamp.json](packer/lamp.json).

 
The AMI can be used to spin up several webservers of the exact same kind. 
This is less error-prone (single point of testing) and faster in scaling than 
provisioning each single EC2 instance after launching it.

### Create infrastructure

Create infrastructure of the LAMP Stack in the cloud:

```
cd terraform/
terraform init
terraform get
terraform apply \
    -var profile=myaccount \
    -var region="us-west-2" 
```

The output you will see is similar to the following:

    Apply complete! Resources: 18 added, 0 changed, 0 destroyed.
        
    Outputs:
     
    elb_dns_name = webserver-elb-1983426762.us-west-2.elb.amazonaws.com
    
 
Open `webserver-elb-1983426762.us-west-2.amazonaws.com` (which is different in your case and each time you create the LAMP Stack)
in your browser of choice and have a look at the test website. It is able to add to and read data from a database
using PHP:

<p>
 <img src="img/webpage.png" alt="Test website of the LAMP Stack">   
 <em>Figure 1: LAMP Stack architecture</em>
</p>

## Tear down LAMP stack

```
cd terraform/
terraform destroy \
    -var profile=myaccount \
    -var region="us-west-2"
```
