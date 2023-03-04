output "vpc_id" {
  description = "VPC Resource ID"
  value       = module.network.vpc_id
}

output "vpc_all_tags" {
  description = "VPC tags"
  value       = module.network.vpc_all_tags
}

output "subnet1_id" {
  description = "ID of the subnet1"
  value       = module.network.subnet1_id
}

output "subnet2_id" {
  description = "ID of the subnet2"
  value       = module.network.subnet2_id
}

output "security-group-alb_id" {
  description = "ID of Security Group for ALB"
  value       = module.network.security-group-alb_id
}

output "security-group-vm_id" {
  description = "ID of Security Group for VMs"
  value       = module.network.security-group-vm_id
}

output "aws_ami_image_id" {
  description = "AMI image ImageId"
  value       = module.autoscaling-lb.aws_ami_image_id
}

output "ec2_user_data_1" {
  description = "user_data of the VMs"
  value       = module.autoscaling-lb.ec2_user_data_1
}

output "ec2_user_data_2" {
  description = "user_data of the VMs"
  value       = module.autoscaling-lb.ec2_user_data_2
}
