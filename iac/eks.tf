locals {
  cluster_name = "demo-eks-cluster"
}


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.31.0" # use the latest version as appropriate

  cluster_name    = local.cluster_name
  cluster_version = "1.31" # update to the latest stable version if needed

  subnet_ids = module.vpc.public_subnets
  vpc_id     = module.vpc.vpc_id

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    main = {
      desired_size = 1
      min_size     = 1
      max_size     = 1

      instance_types = ["t3.small"] # Change as per your need
      capacity_type  = "ON_DEMAND"  # Or "SPOT"
      tags = {
        Name = "eks-node"
      }
    }
  }
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "kubeconfig" {
  value = module.eks.kubeconfig
}


