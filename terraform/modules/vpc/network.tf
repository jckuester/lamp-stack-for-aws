resource "aws_vpc" "lamp" {
  cidr_block = "${var.vpc_cidr}"

  tags {
    Name = "${var.lamp_tag}"
  }
}

resource "aws_internet_gateway" "lamp" {
  vpc_id = "${aws_vpc.lamp.id}"

  tags {
    Name = "${var.lamp_tag}"
  }
}

resource "aws_route_table" "lamp" {
  vpc_id = "${aws_vpc.lamp.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.lamp.id}"
  }

  tags {
    Name = "${var.lamp_tag}"
  }
}
