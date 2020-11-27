output "ec2_public_ip" {
  description = "Ip of the public ec2 instance"
  value       = module.cluster.ec2_public_ip
}

output "nat_gw_elastic_ip" {
  description = "Elastic IP assigned to the NAT gateway"
  value       = module.cluster.nat_gw_elastic_ip
}
