output "ec2_public_ip" {
  description = "Ip of the public ec2 instance"
  value = aws_instance.ec2_pub.public_ip
}

output "nat_gw_elastic_ip" {
  description = "Elastic IP assigned to the NAT gateway"
  value = aws_eip.ngw.public_ip
}