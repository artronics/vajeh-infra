resource "aws_subnet" "platform_subnets" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.platform_cidr, 4, 0)
  availability_zone       = var.platform_subnet_az_1
  map_public_ip_on_launch = false

  tags = {
    Name        = "platform-private-${var.platform_subnet_az_1}"
    Description = "Platform subnet"
  }
}
