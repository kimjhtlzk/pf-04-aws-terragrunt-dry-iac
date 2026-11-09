include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/security_group.hcl"
  merge_strategy = "deep"
}

inputs = {
  security_group = [
    {
      name = "demo-sg-1"
      vpc  = dependency.vpc.outputs.vpc_id["demo-vpc-1"]["vpc_id"]
      ingress_rules = {
        1 = {
          rule_name   = "ssh-from-vpn"
          cidr_blocks = "203.0.113.10/32"
          protocol    = "tcp"
          port_range  = ["22-22"]
        }
      }
      egress_rules = {
        1 = {
          rule_name   = "https-out"
          cidr_blocks = "0.0.0.0/0"
          protocol    = "tcp"
          port_range  = ["443-443"]
        }
      }
    },
  ]
}
