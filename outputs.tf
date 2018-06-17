# -----------------------------------------------------------------------------
# OUTPUTS
# -----------------------------------------------------------------------------
output "pub_ip" {
  value = "${aws_instance.web.public_ip}"
}

output "web_sg" {
  value = "${aws_security_group.web_sg.id}"
}

output "myIP" {
  value = "${var.myIPAddress}"
}
