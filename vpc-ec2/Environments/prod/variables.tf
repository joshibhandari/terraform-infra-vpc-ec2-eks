variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "name for the vpc"
  type        = string 
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
}

variable "aws_region" {
  description = "aws region is"
  type = string
  default = "us-east-1"
}

variable "instance_type" {
  description = "instance type"
  type = string
}

variable "ami" {
  description = "provide a ami for the vm"
  type = string
  # default = "ami-04b4f1a9cf54c11d0"
}

variable "security_group_ingress" {
  description = "List of maps of ingress rules to set on the security group"
  type        = list(map(string))
  default = [
  {
    self             = true
    cidr_blocks      = "0.0.0.0/0"
    ipv6_cidr_blocks = "::/0"
    prefix_list_ids  = ""
    security_groups  = ""
    description      = "Allow all inbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  },
  {
    self             = false
    cidr_blocks      = "192.168.1.0/24"
    ipv6_cidr_blocks = ""
    prefix_list_ids  = ""
    security_groups  = ""
    description      = "Allow inbound traffic from a specific CIDR"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
  }
]
}

variable "security_group_egress" {
  description = "List of maps of egress rules to set on the security group"
  type        = list(map(string))
  default = [
  {
    self             = true
    cidr_blocks      = "0.0.0.0/0"
    ipv6_cidr_blocks = "::/0"
    prefix_list_ids  = ""
    security_groups  = ""
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }
]
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "igw"
}

variable "key_name" {
  description = "Name of the key pair"
  type        = string
}

# variable "public_instance_per_subnet" {
#   description = "Number of amazon linux host"
#   type        = number
# }

# variable "private_instance_per_subnet" {
#   description = "Number of amazon linux host"
#   type        = number
# }

variable "public_instance_distribution" {
  type        = map(number)
  description = "Map of subnet index to number of instances in public subnets"
  default     = {
    # 0 = 2  # 2 instances in the first public subnet
    # 1 = 1  # 1 instance in the second public subnet
  }
}

variable "private_instance_distribution" {
  type        = map(number)
  description = "Map of subnet index to number of instances in private subnets"
  default     = {
    # 0 = 2  # 2 instances in the first private subnet
    # 1 = 1  # 1 instance in the second private subnet
  }
}

variable "private_instance_name" {
  description = "A list of private instance name"
  type = list(string)
}

variable "public_instance_name" {
  description = "Alist of private instance name"
  type = list(string)
}

variable "private_key_location" {
  description = "Location of the private key"
  type        = string
  # default     = "/Users/joshi/.ssh/aws_access_key.pem"
}

variable "public_instance_sg_ports" {

  description = "Define the ports and protocols for the security group"
  type        = list(any)
  default = [
    {
      "port" : 22,
      "protocol" : "tcp"
    },
  ]
}

variable "private_instance_sg_ports" {

  description = "Define the ports and protocols for the security group"
  type        = list(any)
  default = [
    {
      "port" : 22,
      "protocol" : "tcp"
    },
    {
      "port" : -1,
      "protocol" : "icmp"
    }
  ]
}

variable "public_instance_conf" {
  description = "Configuration for public instances"
  type        = list(object({
    ami                    = string
    instance_type          = string
    subnet_id              = string
    key_name               = string
    vpc_security_group_ids = list(string)
    user_data              = string
  }))
}

variable "private_instance_conf" {
  description = "Configuration for private instances"
  type        = list(object({
    ami                    = string
    instance_type          = string
    subnet_id              = string
    key_name               = string
    vpc_security_group_ids = list(string)
  }))
}

variable "profile" {
  description = "profile name to provision infra"
  type = string
}

variable "user_data" {
  description = "the set of commands/data you can provide to a instance at launch time"
  type = string
}

variable "nat_name" {
  description = "name of the nat gateways"
  type = string
  default = "nat_prod"
}

variable "eip_name" {
  description = "Name of the eip"
  type = string
  default = "eip-prod"
}

variable "nat_eip_tags" {
  description = "Additional tags for the NAT EIP"
  type        = map(string)
  default     = {
    "env" = "prod"
  }
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

variable "private_route_table_tags" {
  description = "Additional tags for the private route tables"
  type        = map(string)
  default     = { "Name" = "private_rt_prod"
  "env" = "prod"}
}

variable "public_route_table_tags" {
  description = "Additional tags for the public route tables"
  type        = map(string)
  default     = { "Name" = "public_rt_prod"
  "env" = "prod"}
}

variable "reuse_nat_ips" {
  description = "Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable"
  type        = bool
  default     = false
}

variable "external_nat_ip_ids" {
  description = "List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips)"
  type        = list(string)
  default     = []
}

variable "external_nat_ips" {
  description = "List of EIPs to be used for `nat_public_ips` output (used in combination with reuse_nat_ips and external_nat_ip_ids)"
  type        = list(string)
  default     = []
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = { "Name" = "private_subnet_prod"
  "env" = "prod"}
}

variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  type        = string
  default     = "private-prod"
}

variable "private_subnet_ipv6_prefixes" {
  description = "Assigns IPv6 private subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list"
  type        = list(string)
  default = [  ]
}

variable "private_subnet_assign_ipv6_address_on_creation" {
  description = "Assign IPv6 address on private subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch"
  type        = bool
  default     = null
}

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "public_subnet-prod"
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {
    "Name" = "public_subnet-prod"
    "env" = "prod"
  }
}

variable "public_subnet_ipv6_prefixes" {
  description = "Assigns IPv6 public subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list"
  type        = list(string)
  default = [  ]
}

variable "assign_ipv6_address_on_creation" {
  description = "Assign IPv6 address on subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch"
  type        = bool
  default     = false
}

variable "public_subnet_assign_ipv6_address_on_creation" {
  description = "Assign IPv6 address on public subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch"
  type        = bool
  default     = null
}

variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch"
  type        = bool
  default     = true
}

variable "igw_tags" {
  description = "Additional tags for the internet gateway"
  type        = map(string)
  default     = {"Name" = "igw-prod"
  "env" = "prod"}
}

variable "resource_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "igw-prod"
}

variable "create_igw" {
  description = "Controls if an Internet Gateway is created for public subnets and the related routes that connect them."
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    "env" = "prod"
  }
}

variable "vpc_endpoint_tags" {
  description = "Additional tags for the VPC Endpoints"
  type        = map(string)
  default     = {}
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}

variable "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool"
  type        = list(string)
  default     = []
}

variable "security_groups_name" {
  description = "Name to be used on the default security group"
  type        = string
  default     = "prod-security_group"
}

variable "enable_ipv6" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block."
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = false
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "nat_gateway_tags" {
  description = "Additional tags for the NAT gateways"
  type        = map(string)
  default = {
    "name" = "nat_gateway"
    "env" = "prod"
  }
}