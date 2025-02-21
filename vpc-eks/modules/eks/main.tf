resource "aws_eks_cluster" "eks" {
  name              = var.cluster_name
  role_arn          = aws_iam_role.cluster.arn
  version           = var.eks_version
  bootstrap_self_managed_addons = false
  access_config {
    authentication_mode = "API"
  }
  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids = coalescelist(var.private_subnets)  #module.vpc.private_subnets 
  }
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSComputePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSBlockStoragePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSLoadBalancingPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSNetworkingPolicy,
  ]
    zonal_shift_config {
    enabled = true
  }
    compute_config {
    enabled       = true
    node_pools    = ["general-purpose"]
    node_role_arn = aws_iam_role.node.arn
  }
    kubernetes_network_config {
    elastic_load_balancing {
      enabled = true
    }
  }
  storage_config {
    block_storage {
      enabled = true
    }
  }

}