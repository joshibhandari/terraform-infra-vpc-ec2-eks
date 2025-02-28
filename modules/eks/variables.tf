variable "cluster_name" {
  description = "Name of the eks cluster"
  type = string
}

variable "eks_version" {
  description = "eks cluster version"
  type = string
}

variable "private_subnets" {
  description = "List of private subnet id's"
  type = list(string)
}