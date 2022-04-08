# Fetch-the-latest-AWS-AMI-from-AWS-and-create-an-EC2-instance-using-Terraform

Terraform provides us a way to fetch the latest AMI in AWS while deploying our VMs using Terraform.

----
## What is Amazon Machine Image(AMI)

An Amazon Machine Image (AMI) provides the information required to launch an instance. You must specify an AMI when you launch an instance. You can launch multiple instances from a single AMI when you need multiple instances with the same configuration. You can use different AMIs to launch instances when you need instances with different configurations.

----
## let’s have a look at data source

Now let’s first understand how data source works:

~~~~
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
~~~~

Here the out put will print the latest AMI of the AWS ec2 instance. The out put like this

![Screenshot from 2022-04-08 13-54-37](https://user-images.githubusercontent.com/100773790/162396188-f9d961ac-a02e-4a23-8a14-f6f8809eb7fd.png)

-----
## Calling data source in resources

we have defined the data source but we need to reference this data source inside a resource block to create a resource with the latest AMI.
Here we are creating an EC2instanmce from the latest AMI using the Resource. In the below script we give an AMI input = to the output of the datasource.

~~~
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#Creating EC2 instance from the Latest AMI.
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

resource "aws_instance"  "myapp-instance" {

  ami                     =    data.aws_ami.amazon_latest_ami.image_id
  instance_type           =    "t2.micro"
  key_name                =    	KEY-NAME
  vpc_security_group_ids  =    ["SECURITY-GROUP-ID"]
  tags = {
   Name = "myapp"
   project = live-sb
   env     = dev
  }
}
~~~~
Here I have already created the key_name and vpc_security_group_ids for my project. That is why the reason I have given the existing details as key names and vpc_security_group_ids.

----
## Conclusion

In this tutorial, we discussed how to create an EC2 AWS instance using the latest AMI with Terraform.



### ⚙️ Connect with Me

<p align="center">
 <a href="https://www.instagram.com/_r.e.b.e.l.z_33/"><img src="https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white"/></a>
<a href="https://www.linkedin.com/in/abhiraj-parthan-82038b191"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"/></a> 
