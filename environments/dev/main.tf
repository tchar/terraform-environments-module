# Terraform configuration

provider "aws" {
  profile = var.profile
  region  = var.region
}

module "cluster" {
  source = "../../modules/cluster"

  cluster_type           = "Dev"
  ec2_instance_type      = var.ec2_instance_type
  pubkey_ec2_pub_path    = var.pubkey_ec2_pub_path
  pubkey_ec2_priv_path   = var.pubkey_ec2_priv_path
  public_subnet_av_zone  = var.public_subnet_av_zone
  private_subnet_av_zone = var.private_subnet_av_zone
}
