data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


#resource "aws_ami_copy" "ubuntu" {
#  name              = format("%s_AMI_UBUNTU", var.service_name)
#  description       = "A copy of Ubuntu Bionic 18.04"
#  source_ami_id     = data.aws_ami.ubuntu.id
#  source_ami_region = "us-east-1"
#
#  tags = {
#    Name = format("%s_AMI_UBUNTU", var.service_name)
#  }
#}
