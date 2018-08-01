variable "azs" {
  type = "list"
}

variable "cidr_blocks" {
  type = "list"
}

variable "db_server_address" {}
variable "region" {}

variable "subnet_ids" {
  type = "list"
}

variable "vpc_cidr" {}
variable "vpc_id" {}
variable "webserver_tag" {}