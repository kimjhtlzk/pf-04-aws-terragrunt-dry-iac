include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/instance_profile.hcl"
  merge_strategy = "deep"
}

inputs = {
  instance_profile = [
    {
      name = "demo-ec2-readonly"
      role = "ec2-readonly"
    },
  ]
}
