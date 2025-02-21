vpc_name                      = "my_vpc_prod"
cidr                          = "10.0.0.0/16"
instance_type                 = "t2.micro"
aws_region                    = "us-east-1"
public_subnets                = [ "10.0.0.0/28" ] #[ "10.0.0.0/28", "10.0.0.32/28" ]
private_subnets               = [ "10.0.1.0/28" ] #[ "10.0.1.0/28", "10.0.1.32/28" ]
azs                           = [ "us-east-1a" ] #[ "us-east-1a", "us-east-1b" ]
key_name                      = "aws_access_key"
private_instance_name         = [ "backend-dev" ]
public_instance_name          =  [ "web-dev" ]
private_key_location          = "/Users/joshi/.ssh/aws_access_key.pem"
profile                       = "" # Configure profile or authentication as required.
ami                           = "ami-04b4f1a9cf54c11d0"
public_instance_distribution  = {
  0 = 1  # 2 instances in the first public subnet
  # 1 = 2  # 1 instance in the second public subnet
}

private_instance_distribution = {
  0 = 1  # 2 instances in the first private subnet
  # 1 = 0  # 1 instance in the second private subnet
}
user_data = <<-EOT
  #!/bin/bash
  # Update the system
  apt update -y

  # Install Nginx
  apt install -y nginx

  # Start Nginx service
  systemctl start nginx

  # Enable Nginx to start on boot
  systemctl enable nginx
EOT
public_instance_conf          = [
  {
    ami                    = ""
    instance_type          = ""
    subnet_id              =  "" 
    key_name               = ""
    vpc_security_group_ids = [""] 
    user_data = ""
  }
]

private_instance_conf = [
  {
    ami                    = ""
    instance_type          = ""
    subnet_id              = "" 
    key_name               = ""
    vpc_security_group_ids = [""] 
  }
]