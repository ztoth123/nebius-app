# Create 1 VPC and 2 subnets in 2 availability zones
module "network" {
  source                     = "./modules/network"
  cidr_block_vpc             = var.cidr_block_vpc
  cidr_block_subnet_1        = var.cidr_block_subnet_1
  availability_zone_subnet_1 = var.availability_zone_subnet_1
  subnet_tag_1               = format("%s-%s", var.availability_zone_subnet_1, "subnet")
  cidr_block_subnet_2        = var.cidr_block_subnet_2
  availability_zone_subnet_2 = var.availability_zone_subnet_2
  subnet_tag_2               = format("%s-%s", var.availability_zone_subnet_2, "subnet")
}

# Create 2 Autoscaling Groups, 2 Target Groups, 1 Application Load Balancer
module "autoscaling-lb" {
  source                 = "./modules/autoscaling-lb"
  vpc_id                 = module.network.vpc_id
  subnet1_id             = module.network.subnet1_id
  subnet2_id             = module.network.subnet2_id
  sg-alb_id              = module.network.security-group-alb_id
  sg-vm_id               = module.network.security-group-vm_id
  page1_html             = var.page1_html
  page2_html             = var.page2_html
  page1_desired_capacity = var.page1_desired_capacity
  page1_max_size         = var.page1_max_size
  page1_min_size         = var.page1_min_size
  page2_desired_capacity = var.page2_desired_capacity
  page2_max_size         = var.page2_max_size
  page2_min_size         = var.page2_min_size
}
