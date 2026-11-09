include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/vpc_peering.hcl"
  merge_strategy = "deep"
}

inputs = {
  vpc_peer = [
    {
      peer_type                = "internal"
      target_project_id        = null
      name                     = "demo-peer-01"
      vpc                      = dependency.vpc.outputs.vpc_id["demo-vpc-1"]["vpc_id"]
      target_vpc               = dependency.vpc.outputs.vpc_id["demo-vpc-2"]["vpc_id"]
      other_region             = null
      accepter_dns_resolution  = true
      requester_dns_resolution = true
    },
  ]
}
