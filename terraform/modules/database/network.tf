resource "aws_subnet" "database" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index + 3)}"
  count = "${length(var.azs)}"
  availability_zone = "${element(var.azs, count.index)}"

  tags {
    Name = "LAMP: Database"
  }
}

resource "aws_db_subnet_group" "database" {
  name       = "lamp"
  subnet_ids = ["${aws_subnet.database.*.id}"]

  tags {
    Name = "LAMP: Database"
  }
}
