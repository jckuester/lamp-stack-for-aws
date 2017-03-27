resource "aws_security_group" "webserver" {
  name = "elb -: webserver"
  description = "Allow connections from ELB"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${aws_subnet.webserver.*.cidr_block}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "LAMP: Webserver"
  }
}

resource "aws_security_group" "elb" {
  name = "Internet -: ELB"
  description = "Allow connections from Internet"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "LAMP: ELB"
  }
}
