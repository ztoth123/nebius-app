output "aws_ami_image_id" {
  description = "AMI image ImageId"
  value       = data.aws_ami.ubuntu.id
}

output "ec2_user_data" {
  description = "user_data of the VMs"
  value       = local.userdata
}
