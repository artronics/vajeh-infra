output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_default_security_group" {
  value = aws_default_security_group.default.id
}

output "platform_subnet_ids" {
  value = [aws_subnet.platform_subnets.id]
}
