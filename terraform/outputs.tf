output "vpc_id" {
  description = "VPC Resource ID"
  value       = aws_vpc.main.id
}

output "vpc_all_tags" {
  description = "VPC tags"
  value       = aws_vpc.main.tags_all
}
