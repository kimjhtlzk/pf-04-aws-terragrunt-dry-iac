include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/internet_gateway.hcl"
  merge_strategy = "deep"
}

inputs = {
  igw = [
    {
      name = "igw-demo-vpc-1"
      vpc  = dependency.vpc.outputs.vpc_id["demo-vpc-1"]["vpc_id"]
    },
  ]
}
