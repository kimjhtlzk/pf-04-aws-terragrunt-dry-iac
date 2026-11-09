include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/iam_custom_policy.hcl"
  merge_strategy = "deep"
}

inputs = {
  # Deny every API call that does not come from the office network.
  iam_policy = [
    {
      name = "office-ip-guard"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
          Effect   = "Deny"
          Action   = "*"
          Resource = "*"
          Condition = {
            NotIpAddress = { "aws:SourceIp" = ["203.0.113.0/24", "198.51.100.10/32"] }
            Bool         = { "aws:ViaAWSService" = "false" }
          }
        }]
      })
    },
  ]
}
