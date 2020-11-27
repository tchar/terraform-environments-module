resource "aws_security_group" "ec2_public" {
  name   = "${var.cluster_type}SgEc2Pub"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port        = 8081
    to_port          = 8081
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Allow everywhere for default server port"
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Allow SSH from everywhere"
  }

  tags = {
    Name = "${var.cluster_type}SgEc2Pub"
  }
}

resource "aws_security_group" "outbound_all" {
  name   = "${var.cluster_type}SgOutboundAll"
  vpc_id = aws_vpc.main.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "Allow all outgoing traffic"
  }

  tags = {
    Name = "${var.cluster_type}SgOutboundAll"
  }
}


resource "aws_security_group" "ec2_private" {
  name   = "${var.cluster_type}SgEc2Priv"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    description = "Allow SSH from EC2 public/private subnet"
  }

  tags = {
    Name = "${var.cluster_type}SgEc2Priv"
  }
}
