output "vpc_id" {
  value = "${aws_vpc.lamp.id}"
}

output "route_table_id" {
  value = "${aws_route_table.lamp.id}"
}
