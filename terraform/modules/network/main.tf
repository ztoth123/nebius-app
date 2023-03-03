resource "aws_subnet" "subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block_subnet
  availability_zone = var.availability_zone_subnet
  tags = {
    Name = var.subnet_tag
  }
}
