include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/ebs.hcl"
  merge_strategy = "deep"
}

locals {
  aws_region = read_terragrunt_config(find_in_parent_folders("region.hcl")).locals.aws_region
}

inputs = {
  ebs = [
    {
      name              = "demo-ebs-1"
      availability_zone = "${local.aws_region}a"
      type              = "gp3"
      size              = 40
      snapshot_id       = null
      iops              = null
      throughput        = null
      device_name       = null
    },
  ]
}
