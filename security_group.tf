resource "aws_security_group" "private_sg" {
  name        = "${var.name}-private-sg"
  description = "Security Group for Private EC2 instance"
  vpc_id      = data.aws_vpc.selected.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-private-sg"
    Product = var.name
  }
}