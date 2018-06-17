# -----------------------------------------------------------------------------
# Create a Security Group for the Instance
# -----------------------------------------------------------------------------
resource "aws_security_group" "web_sg" {
  name = "web-example"

  # Inbound SSH from myOffice
  ingress {
    from_port = "${var.comms_port}"
    to_port   = "${var.comms_port}"
    protocol  = "tcp"

    cidr_blocks = [
      "${var.myIPAddress}",
    ]
  }

  # Inbound HTTP from myOffice
  ingress {
    from_port = "${var.http_port}"
    to_port   = "${var.http_port}"
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  # Allow all outbound traffic: for now
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}
