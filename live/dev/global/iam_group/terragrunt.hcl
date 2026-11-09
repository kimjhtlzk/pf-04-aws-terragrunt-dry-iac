include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/iam_group.hcl"
  merge_strategy = "deep"
}

inputs = {
  iam_group = [
    {
      name   = "infra-common"
      policy = [lookup(dependency.iam_custom_policy.outputs.policy_arn, "office-ip-guard", "arn:aws:iam::aws:policy/office-ip-guard")]
      users  = keys(dependency.iam_user.outputs.user_names)
    },
    {
      name   = "infra-admin"
      policy = ["arn:aws:iam::aws:policy/IAMFullAccess"]
      users  = []
    },
  ]
}
