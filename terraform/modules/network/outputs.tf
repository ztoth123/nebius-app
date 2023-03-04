output "vpc_id" {
  description = "VPC Resource ID"
  value       = aws_vpc.main.id
}

output "vpc_all_tags" {
  description = "VPC tags"
  value       = aws_vpc.main.tags_all
}

output "subnet1_id" {
  description = "ID of the subnet1"
  value       = aws_subnet.subnet1.id
}

output "subnet2_id" {
  description = "ID of the subnet2"
  value       = aws_subnet.subnet2.id
}
