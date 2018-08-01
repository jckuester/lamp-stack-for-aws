resource "aws_elb" "webserver" {
  name = "webserver-elb"
  internal = false
  subnets = ["${var.subnet_ids}"]
  security_groups = ["${aws_security_group.elb.id}"]

  listener {
    instance_port = 80
    instance_protocol = "tcp"
    lb_port = 80
    lb_protocol = "tcp"
  }

  tags {
    Name = "${var.webserver_tag}"
  }
}