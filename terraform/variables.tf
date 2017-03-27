variable "webserver_tag" {
  default = "LAMP: Webserver"
}

variable "azs" {
  type = "list"
  default = ["us-west-2a", "us-west-2b"]
}
