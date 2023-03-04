resource "aws_vpc" "main" {
  cidr_block = var.cidr_block_vpc
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_block_subnet_1
  availability_zone = var.availability_zone_subnet_1
  tags = {
    Name = var.subnet_tag_1
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_block_subnet_2
  availability_zone = var.availability_zone_subnet_2
  tags = {
    Name = var.subnet_tag_2
  }
}

resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id
}