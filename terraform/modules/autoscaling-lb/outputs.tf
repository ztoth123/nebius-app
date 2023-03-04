output "aws_ami_image_id" {
  description = "AMI image ImageId"
  value       = data.aws_ami.ubuntu.id
}

output "ec2_user_data_1" {
  description = "user_data of the VMs"
  value       = local.userdata_1
}

output "ec2_user_data_2" {
  description = "user_data of the VMs"
  value       = local.userdata_2
}
