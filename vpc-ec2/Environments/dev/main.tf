locals {
  public_subnets              = module.vpc.public_subnet_ids
  private_subnets             = module.vpc.private_subnet_ids
  vpc_id                      = module.vpc.vpc_id

  public_instance_conf = flatten([
    for index, subnet in var.public_subnets : [
      for i in range(lookup(var.public_instance_distribution, index, 0)) : {
        ami                    = var.ami
        instance_type          = var.instance_type
        subnet_id              = local.public_subnets[0] 
        key_name               = var.key_name
        vpc_security_group_ids = [module.ec2.public_security_group_id]
        user_data              = var.user_data
      }
    ]
  ])

  private_instance_conf = flatten([
    for index, subnet in var.private_subnets : [
      for i in range(lookup(var.private_instance_distribution, index, 0)) : {
        ami                    = var.ami
        instance_type          = var.instance_type
        subnet_id              = local.private_subnets[0] 
        key_name               = var.key_name
        vpc_security_group_ids = [module.ec2.private_security_group_id]
      }
    ]
  ])
}

module "vpc" {
  source                        = "../../modules/vpc"
  vpc_name                      = var.vpc_name
  cidr                          = var.cidr
  public_subnets                = var.public_subnets
  private_subnets               = var.private_subnets
  azs                           = var.azs
  resource_name                 = var.resource_name
  security_group_ingress        = var.security_group_ingress
  security_group_egress         = var.security_group_egress
  nat_eip_tags                  = var.nat_eip_tags
  private_route_table_tags      = var.private_route_table_tags
  vpc_endpoint_tags             = var.vpc_endpoint_tags
  tags                          = var.tags
  private_subnet_ipv6_prefixes  = var.private_subnet_ipv6_prefixes
  external_nat_ip_ids           = var.external_nat_ip_ids
  secondary_cidr_blocks         = var.secondary_cidr_blocks
  enable_ipv6                   = var.enable_ipv6
  enable_nat_gateway            = var.enable_nat_gateway
  nat_name                      = var.nat_name
  nat_gateway_tags              = var.nat_gateway_tags
  private_subnet_suffix         = var.private_subnet_suffix
  enable_dns_hostnames          = var.enable_dns_hostnames
  map_public_ip_on_launch       = var.map_public_ip_on_launch
  public_subnet_ipv6_prefixes   = var.public_subnet_ipv6_prefixes
  one_nat_gateway_per_az        = var.one_nat_gateway_per_az
  private_subnet_tags           = var.private_subnet_tags
  public_subnet_assign_ipv6_address_on_creation = var.public_subnet_assign_ipv6_address_on_creation
  eip_name                      = var.eip_name
  public_subnet_suffix          = var.public_subnet_suffix
  create_igw                    = var.create_igw
  security_groups_name          = var.security_groups_name
  public_route_table_tags       = var.public_route_table_tags
  private_subnet_assign_ipv6_address_on_creation = var.private_subnet_assign_ipv6_address_on_creation
  reuse_nat_ips                 = var.reuse_nat_ips
  enable_dns_support            = var.enable_dns_support
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  public_subnet_tags            = var.public_subnet_tags
  igw_tags                      = var.igw_tags
  instance_tenancy              = var.instance_tenancy
  create_vpc                    = var.create_vpc
}

module "ec2" {
  source                        = "../../modules/ec2"
  vpc_id                        = module.vpc.vpc_id
  public_subnets                = module.vpc.public_subnet_ids
  private_subnets               = module.vpc.private_subnet_ids
  public_instance_sg_ports      = var.public_instance_sg_ports
  private_instance_distribution = var.private_instance_distribution
  public_instance_distribution  = var.public_instance_distribution
  private_instance_sg_ports     = var.private_instance_sg_ports
  instance_type                 = var.instance_type
  private_key_location          = var.private_key_location
  key_name                      = var.key_name
  private_instance_name         = var.private_instance_name
  public_instance_name          = var.public_instance_name
  public_instance_conf          = local.public_instance_conf
  private_instance_conf         = local.private_instance_conf

}