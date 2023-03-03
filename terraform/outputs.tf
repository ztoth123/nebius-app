output "vpc_id" {
  description = "VPC Resource ID"
  value       = aws_vpc.main.id
}

output "vpc_all_tags" {
  description = "VPC tags"
  value       = aws_vpc.main.tags_all
}

output "aws_ami_image_id" {
  description = "AMI image ImageId"
  value       = module.autoscaling-groups.aws_ami_image_id
}

output "ec2_user_data" {
  description = "user_data of the VMs"
  value       = module.autoscaling-groups.ec2_user_data
}

/* output "subnet_id" {
  description = "AWS subnet ID"
  value       = module.vpc-subnets.subnet_id
} */