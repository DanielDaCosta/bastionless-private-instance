
variable "instance_type" {
  default = "t3a.medium"
}

variable "image_ami" {
  default = "ami-0817d428a6fb68645"
}

variable "name" {
  description = "Application name"
  type = string
}

variable "region" {
  default = "us-east-1"
}

# variable "vpc_id" {
#   description = "Vpc id to setup bastion"
#   type        = string
# }
variable "environment" {
  description = "Env"
  default     = "dev"
}

locals {
  name_dash = "risk-mg-platform-${var.environment}"
}

variable "key_name" {
  type = string
}