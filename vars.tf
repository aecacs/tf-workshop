# -----------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# vim: et:ts=2:sw=2
# -----------------------------------------------------------------------------
variable "region" {
  description = "The default DEV region"
  default     = "us-west-2"
}

# -----------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# -----------------------------------------------------------------------------
# Define COMMS port
variable "comms_port" {
  description = "The port the server will use for SSH requests"
  default     = 22
}

# Define web call
variable "http_port" {
  description = "The port used for outbound HTTP service requests"
  default     = 80
}
