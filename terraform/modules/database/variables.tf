variable "azs" {
  type = "list"
}

variable "database_tag" {}
variable "region" {}

variable "subnet_ids" {
  type = "list"
}

variable "vpc_cidr" {}
variable "vpc_id" {}

variable "webserver_cidrs" {
  type = "list"
}
