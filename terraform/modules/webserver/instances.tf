resource "aws_autoscaling_group" "webserver" {
  name = "${aws_launch_configuration.webserver.name}"
  launch_configuration = "${aws_launch_configuration.webserver.name}"

  max_size = "${4 * length(var.azs)}"
  min_size = 2

  vpc_zone_identifier = ["${aws_subnet.webserver.*.id}"]
  load_balancers = [ "${aws_elb.webserver.name}" ]

  tag {
    key = "Name"
    value = "LAMP: Webserver"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "webserver" {
  name_prefix = "webserver-"
  image_id = "${data.aws_ami.webserver.id}"
  instance_type = "t2.micro"
  security_groups = [
    "${aws_security_group.webserver.id}"
 ]

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_ami" "webserver" {
  most_recent = true
  owners = ["${var.ami_owner_id}"]

  filter {
    name = "name"
    values = ["apache2-*"]
  }

  filter {
    name = "state"
    values = ["available"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "is-public"
    values = ["false"]
  }
}
