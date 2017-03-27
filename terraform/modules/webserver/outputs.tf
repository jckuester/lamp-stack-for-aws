output "elb_dns_name" {
  value = "${aws_elb.webserver.dns_name}"
}

output "webserver_cidrs" {
  value = "${join(", ", aws_subnet.webserver.*.cidr_block)}"
}
