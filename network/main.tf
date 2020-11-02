locals {
  count = length(var.availability_zones)
  name  = replace(var.name, "-", "_")
}

provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

terraform {
  backend "s3" {
    bucket = "cyberlabs-terraform-risk"
    key    = "risk-management-network-dev"
    region = "us-east-1"
  }
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = upper("VPC_${local.name}")
    Product = var.name
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.this.id
  tags = {
    Product = var.name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name    = upper("IGW_${local.name}")
    Product = var.name
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public.*.id, 0)
  depends_on    = [aws_internet_gateway.this]

  tags = {
    Name    = "${var.name}-nat-gateway"
    Product = var.name
  }
}

