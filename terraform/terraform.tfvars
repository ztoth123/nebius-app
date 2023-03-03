# Network
cidr_block_vpc = "10.0.0.0/16"
vpc_subnets = {
  subnet_az_a = {
    cidr_block_subnet = "10.0.1.0/24",
    availability_zone = "eu-west-1a"
  },
  subnet_az_b = {
    cidr_block_subnet = "10.0.2.0/24",
    availability_zone = "eu-west-1b"
  }
}

# Autoscaling Groups

# Application Load Balancer
