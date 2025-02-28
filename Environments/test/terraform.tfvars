vpc_name                      = "my_vpc_staging"
cidr                          = "10.0.0.0/16"
instance_type                 = "t2.micro"
aws_region                    = "us-east-1"
azs                           = [ "us-east-1a", "us-east-1b" ]
public_subnets                = [ "10.0.0.0/28", "10.0.0.32/28" ]
private_subnets               = [ "10.0.1.0/28", "10.0.1.32/28" ]
private_instance_name         = [ "backend-staging" ]
public_instance_name          =  [ "web-staging" ]
ami                           = "ami-04b4f1a9cf54c11d0"
profile                       = "joshi" # Configure profile or authentication as required.
cluster_name                  = "eks-auto-test"
eks_version                   = "1.31"
key_name                      = "aws_access_key" 
private_key_location          = "/Users/joshi/.ssh/aws_access_key.pem"
eks_cluster_enabled           = false # Identifies the subnet for ELB (Elastic Load Balancer) usage in Kubernetes [ if infra for eks make it as true ].
create_key_pair               = false # Make it as true to create key pair
public_instance_distribution  = {
  0 = 0  # 2 instances in the first public subnet
  1 = 0  # 1 instance in the second public subnet
}
private_instance_distribution = {
  0 = 0  # 2 instances in the first private subnet
  1 = 0  # 1 instance in the second private subnet
}
user_data                   = <<-EOT
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
public_instance_conf = [
  {
    ami                    = ""
    instance_type          = ""
    subnet_id              =  "" 
    key_name               = ""
    vpc_security_group_ids = [""] 
    user_data              = ""
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