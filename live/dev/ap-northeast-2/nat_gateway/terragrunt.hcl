include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/nat_gateway.hcl"
  merge_strategy = "deep"
}

inputs = {
  ngw = [
    {
      name       = "ngw-demo-vpc-1"
      eip        = dependency.elastic_ip.outputs.eip_id["demo-eip-2"]
      subnets    = dependency.vpc.outputs.subnets_ids["demo-vpc-1-subnet-1"]
      private_ip = "10.0.11.250"
    },
  ]
}
