# Create 1 new VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block_vpc
}

# Create 2 subnets on 2 availability zones
module "vpc-subnets" {
  for_each                 = var.vpc_subnets
  source                   = "./modules/network"
  vpc_id                   = aws_vpc.main.id
  cidr_block_subnet        = each.value["cidr_block_subnet"]
  availability_zone_subnet = each.value["availability_zone"]
  subnet_tag               = each.key
}

# Create 2 Autoscaling Groups
module "autoscaling-groups" {
  source = "./modules/autoscaling-groups"
}