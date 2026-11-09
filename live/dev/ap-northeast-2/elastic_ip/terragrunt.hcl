include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/elastic_ip.hcl"
  merge_strategy = "deep"
}

inputs = {
  eip = [
    { name = "demo-eip-1" },
    { name = "demo-eip-2" },
  ]
}
