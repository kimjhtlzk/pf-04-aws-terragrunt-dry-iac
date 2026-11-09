include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/elasticache_subnet_group.hcl"
  merge_strategy = "deep"
}

inputs = {
  elasticache_subnet_group = [
    {
      name = "demo-subnetgroup-1"
      subnets = [
        dependency.vpc.outputs.subnets_ids["demo-vpc-1-subnet-1"],
        dependency.vpc.outputs.subnets_ids["demo-vpc-1-subnet-2"],
      ]
    },
  ]
}
