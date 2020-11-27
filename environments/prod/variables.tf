variable "profile" {
  type    = string
  default = "default"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "pubkey_ec2_pub_path" {
  type    = string
  default = "keys/ec2_pub_rsa.pub"
}

variable "pubkey_ec2_priv_path" {
  type    = string
  default = "keys/ec2_priv_rsa.pub"
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "public_subnet_av_zone" {
  type    = string
  default = "us-east-1b"
}

variable "private_subnet_av_zone" {
  type    = string
  default = "us-east-1c"
}
