# ------------------------------------------------------------------------------
# This file defines an EC2 instance with:
#   * Its own security group(s).
#   * That leverages our ssh key(s).
#   * Executes a simple script that starts nginx.
# vim: et:ts=2:sw=2
# ------------------------------------------------------------------------------
# CONFIGURE THE AWS CONNECTION AND AUTH
# ------------------------------------------------------------------------------
provider "aws" {
  region = "${var.region}"
}

# -----------------------------------------------------------------------------
# Deploy a single EC2 Instance
# -----------------------------------------------------------------------------
resource "aws_instance" "web" {
  ami           = "${data.aws_ami.base_ami.id}"
  instance_type = "t2.micro"

  # The ssh key used to login to instances;
  key_name = "master"

  # Install and Start nginx
  user_data = "${file("scripts/web_bootstrap.sh")}"

  # FIXME: subnet_id is brittle; should use a data source
  # URL: https://www.terraform.io/docs/configuration/data-sources.html
  subnet_id = "subnet-bfd942c6"

  vpc_security_group_ids = [
    "${aws_security_group.web_sg.id}",
  ]

  tags {
    Name = "web-example"
  }

  # Connect from the office
  associate_public_ip_address = true

  # Record the IP address of the new machine
  provisioner "local-exec" {
    command = "echo ${aws_instance.web.public_ip} > /tmp/rhost.tfout"
  }

  tags {
    Name = "web-${format("%02d", count.index + 1)}"
  }
}

# -----------------------------------------------------------------------------
# Find the latest AMI; NOTE: MUST produce only 1 AMI ID.
# -----------------------------------------------------------------------------
data "aws_ami" "base_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*debian-stretch-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["379101102735"]
}
