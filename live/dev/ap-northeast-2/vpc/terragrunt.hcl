include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/vpc.hcl"
  merge_strategy = "deep"
}

locals {
  aws_region = read_terragrunt_config(find_in_parent_folders("region.hcl")).locals.aws_region
}

inputs = {
  # A VPC is replaced when cidr_block changes.
  # A subnet is replaced when subnet_cidr or availability_zone changes.
  vpcs = [
    {
      name                = "demo-vpc-1"
      cidr_block          = "10.0.0.0/16"
      use_ipv6_cidr_block = false
      subnets = [
        {
          subnet_name       = "demo-vpc-1-subnet-1"
          subnet_cidr       = "10.0.11.0/24"
          ipv6_cidr_block   = null
          availability_zone = "${local.aws_region}a"
          autoassign_public = false
          tags              = { "kubernetes.io/role/internal-elb" = "1" }
        },
        {
          subnet_name       = "demo-vpc-1-subnet-2"
          subnet_cidr       = "10.0.12.0/24"
          ipv6_cidr_block   = null
          availability_zone = "${local.aws_region}b"
          autoassign_public = false
          tags              = { "kubernetes.io/role/internal-elb" = "1" }
        },
      ]
    },
    {
      name                = "demo-vpc-2"
      cidr_block          = "10.1.0.0/16"
      use_ipv6_cidr_block = false
      subnets = [
        {
          subnet_name       = "demo-vpc-2-subnet-1"
          subnet_cidr       = "10.1.11.0/24"
          ipv6_cidr_block   = null
          availability_zone = "${local.aws_region}a"
          autoassign_public = false
          tags              = {}
        },
      ]
    },
  ]
}
