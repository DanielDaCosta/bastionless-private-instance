data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["VPC_${upper(replace(local.name_dash, "-", "_"))}"]
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Tier = "Public"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Tier = "Private"
  }
}

data "aws_subnet" "public" {
  for_each = data.aws_subnet_ids.public.ids
  id       = each.value
}