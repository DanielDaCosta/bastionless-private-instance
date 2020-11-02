resource "aws_instance" "private_server" {
  ami                         = var.image_ami
  associate_public_ip_address = false
  disable_api_termination     = true
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  subnet_id                   = element(tolist(data.aws_subnet_ids.private.ids), 0)
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name    = "${var.name}-private-server"
    Product = var.name
  }

  volume_tags = {
    Name    = "${var.name}-private-server-volume"
    Product = var.name
  }
}