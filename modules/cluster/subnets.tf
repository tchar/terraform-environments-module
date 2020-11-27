resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.public_subnet_av_zone
  tags = {
    Name = "${var.cluster_type}SubnetPub"
  }
  depends_on = [aws_internet_gateway.main]
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.private_subnet_av_zone
  tags = {
    Name = "${var.cluster_type}SubnetPriv"
  }
}
