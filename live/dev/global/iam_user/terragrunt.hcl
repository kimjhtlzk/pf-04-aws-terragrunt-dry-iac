include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/iam_user.hcl"
  merge_strategy = "deep"
}

inputs = {
  iam_user = [
    {
      name   = "demo-user-1"
      policy = [lookup(dependency.iam_custom_policy.outputs.policy_arn, "office-ip-guard", "arn:aws:iam::aws:policy/office-ip-guard")]
    },
    {
      name   = "demo-user-2"
      policy = [lookup(dependency.iam_custom_policy.outputs.policy_arn, "office-ip-guard", "arn:aws:iam::aws:policy/office-ip-guard")]
    },
  ]
}
