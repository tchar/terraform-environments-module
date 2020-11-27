resource "aws_eip" "ngw" {
  vpc = true

  tags = {
    Name = "${var.cluster_type}Eip"
  }
}
