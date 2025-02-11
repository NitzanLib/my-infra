resource "aws_subnet" "public_subnets" {
  count = 2
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = "10.0.${count.index + 1}.0/24"
  availability_zone = element(["eu-west-1a", "eu-west-1b"], count.index)

  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = 2
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = "10.0.${count.index + 3}.0/24"
  availability_zone = element(["eu-west-1a", "eu-west-1b"], count.index)

  tags = {
    Name = "private-subnet-${count.index}"
  }
}
