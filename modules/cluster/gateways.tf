resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.cluster_type}Igw"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.ngw.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "${var.cluster_type}Ngw"
  }

  depends_on = [aws_internet_gateway.main]
}
