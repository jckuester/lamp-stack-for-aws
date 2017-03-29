variable "webserver_tag" {
  default = "LAMP: Webserver"
}

variable "database_tag" {
  default = "LAMP: Database"
}

variable "azs" {
  type = "list"
  default = ["a", "b"]
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "PROFILE" { }

variable "REGION" { }
