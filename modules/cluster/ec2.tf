resource "aws_instance" "ec2_pub" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type
  tags = {
    Name = "${var.cluster_type}Ec2UbuntuPub"
  }
  vpc_security_group_ids = [
    aws_security_group.ec2_public.id,
    aws_security_group.outbound_all.id,
  ]
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  private_ip                  = "10.0.1.50"
  key_name                    = aws_key_pair.ec2_pub.key_name
  depends_on                  = [aws_key_pair.ec2_pub]
}


resource "aws_instance" "ec2_priv" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type
  tags = {
    Name = "${var.cluster_type}Ec2UbuntuPriv"
  }
  vpc_security_group_ids      = [
    aws_security_group.ec2_private.id,
    aws_security_group.outbound_all.id
  ]
  subnet_id                   = aws_subnet.private.id
  associate_public_ip_address = false
  private_ip                  = "10.0.2.50"
  key_name                    = aws_key_pair.ec2_priv.key_name
  depends_on                  = [aws_key_pair.ec2_priv]
}
