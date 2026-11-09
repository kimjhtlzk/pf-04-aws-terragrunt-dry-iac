include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/route_table.hcl"
  merge_strategy = "deep"
}

inputs = {
  route_table = [
    {
      name = "rt-demo-vpc-1"
      vpc  = dependency.vpc.outputs.vpc_id["demo-vpc-1"]["vpc_id"]
      subnets = [
        dependency.vpc.outputs.subnets_ids["demo-vpc-1-subnet-1"],
        dependency.vpc.outputs.subnets_ids["demo-vpc-1-subnet-2"],
      ]
      rule = {
        1 = {
          cidr_block    = "0.0.0.0/0"
          resource_type = "igw"
          resource_name = dependency.internet_gateway.outputs.igw_id["igw-demo-vpc-1"]
        }
        2 = {
          cidr_block    = "10.2.0.0/16"
          resource_type = "ngw"
          resource_name = dependency.nat_gateway.outputs.ngw_id["ngw-demo-vpc-1"]
        }
      }
    },
    {
      name    = "rt-demo-vpc-2"
      vpc     = dependency.vpc.outputs.vpc_id["demo-vpc-2"]["vpc_id"]
      subnets = [dependency.vpc.outputs.subnets_ids["demo-vpc-2-subnet-1"]]
      rule = {
        1 = {
          cidr_block    = "10.0.0.0/16"
          resource_type = "peering"
          resource_name = dependency.vpc_peering.outputs.vpc_peering_id["demo-peer-01"]
        }
      }
    },
  ]
}
