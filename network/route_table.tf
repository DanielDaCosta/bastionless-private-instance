
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name    = upper("RT_PUBLIC_${local.name}")
    Product = var.name
  }
}

resource "aws_route_table_association" "public" {
  count          = local.count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_default_route_table" "private" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name    = upper("RT_PRIVATE_${local.name}")
    Product = var.name
  }
}

resource "aws_route_table_association" "private" {
  count          = local.count
  route_table_id = aws_vpc.this.main_route_table_id
  subnet_id      = aws_subnet.private[count.index].id
}
