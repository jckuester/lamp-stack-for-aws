provider "aws" {
  version = "~> 1.0"

  # default location is $HOME/.aws/credentials
  profile = "${var.profile}"
  region  = "${var.region}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.37.0"

  name = "my-lamp-stack"
  cidr = "${var.vpc_cidr_block}"

  azs             = ["us-west-2a", "us-west-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  # tags to add to all resources
  tags = {
    Name        = "LAMP"
    Terraform   = "true"
    Environment = "dev"
  }
}

module "webserver" {
  source = "modules/webserver"

  azs               = "${var.azs}"
  cidr_blocks       = "${module.vpc.public_subnets_cidr_blocks}"
  db_server_address = "${module.database.server_address}"
  region            = "${var.region}"
  subnet_ids        = "${module.vpc.public_subnets}"
  vpc_cidr          = "${var.vpc_cidr_block}"
  vpc_id            = "${module.vpc.vpc_id}"
  webserver_tag     = "${var.webserver_tag}"
}

module "database" {
  source = "modules/database"

  azs             = "${var.azs}"
  database_tag    = "${var.database_tag}"
  region          = "${var.region}"
  subnet_ids      = "${module.vpc.private_subnets}"
  vpc_cidr        = "${var.vpc_cidr_block}"
  vpc_id          = "${module.vpc.vpc_id}"
  webserver_cidrs = "${module.vpc.public_subnets_cidr_blocks}"
}
