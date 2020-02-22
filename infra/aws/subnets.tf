locals {
  public_cidr     = cidrsubnet(var.vpc_cidr, 4, 0)
  management_cidr = cidrsubnet(var.vpc_cidr, 4, 1)
}

resource "aws_subnet" "public_subnet" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(local.public_cidr, 4, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(
    var.tags,
    { Name = "${var.environment_name}-public-subnet-${count.index}" },
  )
}

resource "aws_subnet" "management_subnet" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(local.management_cidr, 4, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(
    var.tags,
    { Name = "${var.environment_name}-management-subnet-${count.index}" }
  )
}