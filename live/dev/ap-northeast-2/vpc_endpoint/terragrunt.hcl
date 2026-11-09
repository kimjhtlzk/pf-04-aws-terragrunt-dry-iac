include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/vpc_endpoint.hcl"
  merge_strategy = "deep"
}

locals {
  aws_region = read_terragrunt_config(find_in_parent_folders("region.hcl")).locals.aws_region
}

inputs = {
  eps = [
    {
      name   = "endpoint-demo-vpc-1"
      vpc    = dependency.vpc.outputs.vpc_id["demo-vpc-1"]["vpc_id"]
      region = local.aws_region
    },
  ]
}
