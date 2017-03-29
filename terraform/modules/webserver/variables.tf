variable "vpc_id" { }
variable "vpc_cidr" { }
variable "azs" { type = "list"}

# dependencies from other modules
variable "webserver_tag" { }
variable "db_server_address" { }
