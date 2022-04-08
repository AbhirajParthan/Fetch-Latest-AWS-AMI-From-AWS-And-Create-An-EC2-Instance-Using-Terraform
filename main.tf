#++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Amazon Linux Latest AMI printing using data source
#++++++++++++++++++++++++++++++++++++++++++++++++++++++

data "aws_ami" "amazon_latest_ami"  {

	most_recent      = true
        owners = ["amazon"]	

filter {
    name = "name"
    
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
}

}

output "fetched_latest_amazon_linux_ami"  {

	value = data.aws_ami.amazon_latest_ami.image_id
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#Creating EC2 instance from the Latest AMI.
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

resource "aws_instance"  "myapp-instance" {

  ami                     =    data.aws_ami.amazon_latest_ami.image_id
  instance_type           =    "t2.micro"
  key_name                =    KEY-NAME
  vpc_security_group_ids  =    ["SECURITY-GROUP-ID"]
  tags = {
   Name = "myapp"
   project = live-sb
   env     = dev
  }
}

