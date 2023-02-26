resource "aws_vpc" "vpc" {
  cidr_block = local.vpc_cidr

  tags = {
    Name = "vajeh-${var.account_name}"
  }
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}
