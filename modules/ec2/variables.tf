variable "vpc_id" {
  description = "VPC ID where the instances will be deployed"
  type        = string
}

variable "instance_type" {
  description = "Name of the project"
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

variable "private_key_location" {
  description = "Location of the private key"
  type        = string
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

variable "public_instance_name" {
  description = "A list of public instance name"
  type = list(string)
}

variable "private_instance_name" {
  description = "A list of private instance name"
  type = list(string)
}

variable "create_key_pair" {
  description = "Create key_ pair"
  type = bool
}

variable "private_sg" {
  description = "Name of the private security group"
  type        = string
}

variable "public_sg" {
  description = "Name of the public security group"
  type        = string
}

variable "env" {
  description = "Name of the environment"
  type = string
}