variable "cluster_type" {
  type = string
}

variable "ec2_instance_type" {
  type    = string
}

variable "pubkey_ec2_pub_path" {
  type = string
}

variable "pubkey_ec2_priv_path" {
  type = string
}

variable "public_subnet_av_zone" {
  type = string
}

variable "private_subnet_av_zone" {
  type = string
}