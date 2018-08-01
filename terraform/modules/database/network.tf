resource "aws_db_subnet_group" "database" {
  name       = "lamp"
  subnet_ids = ["${var.subnet_ids}"]

  tags {
    Name = "${var.database_tag}"
  }
}
