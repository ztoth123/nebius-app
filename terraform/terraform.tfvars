# Network
cidr_block_vpc = "10.0.0.0/16"

cidr_block_subnet_1        = "10.0.1.0/24"
availability_zone_subnet_1 = "eu-west-1a"
cidr_block_subnet_2        = "10.0.2.0/24"
availability_zone_subnet_2 = "eu-west-1b"

# Autoscaling Groups, TargetGroups, Application Load Balancer
page1_html = "page1.html"
page2_html = "page2.html"

page1_desired_capacity = 2
page1_max_size         = 2
page1_min_size         = 1

page2_desired_capacity = 2
page2_max_size         = 2
page2_min_size         = 1