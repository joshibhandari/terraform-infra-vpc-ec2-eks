variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
}

variable "vpc_name" {
  description = "name for the vpc"
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string

}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}


variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
}

variable "enable_ipv6" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block."
  type        = bool
}

variable "security_group_ingress" {
  description = "List of maps of ingress rules to set on the default security group"
  type        = list(map(string))
}

variable "security_group_egress" {
  description = "List of maps of egress rules to set on the default security group"
  type        = list(map(string))
}

variable "security_groups_name" {
  description = "Name to be used on the default security group"
  type        = string
}

variable "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
  type        = bool
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
}

variable "vpc_endpoint_tags" {
  description = "Additional tags for the VPC Endpoints"
  type        = map(string)
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "create_igw" {
  description = "Controls if an Internet Gateway is created for public subnets and the related routes that connect them."
  type        = bool
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
}

variable "resource_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "igw_tags" {
  description = "Additional tags for the internet gateway"
  type        = map(string)
}

variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch"
  type        = bool
}

variable "public_subnet_assign_ipv6_address_on_creation" {
  description = "Assign IPv6 address on public subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch"
  type        = bool
}

variable "assign_ipv6_address_on_creation" {
  description = "Assign IPv6 address on subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch"
  type        = bool
}

variable "public_subnet_ipv6_prefixes" {
  description = "Assigns IPv6 public subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list"
  type        = list(string)
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
}

variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
}

variable "private_subnet_assign_ipv6_address_on_creation" {
  description = "Assign IPv6 address on private subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch"
  type        = bool
}

variable "private_subnet_ipv6_prefixes" {
  description = "Assigns IPv6 private subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list"
  type        = list(string)
}

variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  type        = string
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
}

variable "reuse_nat_ips" {
  description = "Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable"
  type        = bool
}

variable "public_route_table_tags" {
  description = "Additional tags for the public route tables"
  type        = map(string)
}

variable "private_route_table_tags" {
  description = "Additional tags for the private route tables"
  type        = map(string)
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
}

variable "external_nat_ip_ids" {
  description = "List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips)"
  type        = list(string)
}

variable "nat_gateway_tags" {
  description = "Additional tags for the NAT gateways"
  type        = map(string)
}

variable "nat_eip_tags" {
  description = "Additional tags for the NAT EIP"
  type        = map(string)
}

variable "eip_name" {
  description = "Name of the eip"
  type = string
}

variable "nat_name" {
  description = "name of the nat gateways"
  type = string
}

variable "eks_cluster_enabled" {
  type    = bool
}

variable "env" {
  description = "Name of the environment"
  type = string
}