resource "aws_key_pair" "ec2_pub" {
  key_name = "${var.cluster_type}Ec2Pub"
  public_key = file(var.pubkey_ec2_pub_path)
}

resource "aws_key_pair" "ec2_priv" {
  key_name = "${var.cluster_type}Ec2Priv"
  public_key = file(var.pubkey_ec2_priv_path)
}
