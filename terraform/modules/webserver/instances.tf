data "template_file" "index_php" {
  template = "${file("${path.module}/index.php")}"

  vars {
    db_server_address = "${var.db_server_address}"
  }
}


data "template_cloudinit_config" "readmodel" {
  gzip          = true
  base64_encode = false

  part {
    content_type = "text/part-handler"
    content = "${file("${path.module}/../part-handler-text.py")}"
  }

  part {
    content_type = "text/plain-base64"
    filename = "/var/www/index.php"
    content = "${base64encode("${data.template_file.index_php.rendered}")}"
  }
}

resource "aws_autoscaling_group" "webserver" {
  name = "${aws_launch_configuration.webserver.name}"
  launch_configuration = "${aws_launch_configuration.webserver.name}"

  max_size = "${4 * length(var.azs)}"
  min_size = 2

  vpc_zone_identifier = ["${aws_subnet.webserver.*.id}"]
  load_balancers = [ "${aws_elb.webserver.name}" ]

  tag {
    key = "Name"
    value = "${var.webserver_tag}"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "webserver" {
  name_prefix = "webserver-"
  image_id = "${data.aws_ami.webserver.id}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.webserver.key_name}"
  user_data = "${data.template_cloudinit_config.readmodel.rendered}"
  security_groups = [
    "${aws_security_group.webserver.id}"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_ami" "webserver" {
  most_recent = true
  owners = ["${data.aws_caller_identity.current.account_id}"]

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

data "aws_caller_identity" "current" {
  # no arguments
}
