resource "aws_iam_user" "iam_user" {
  #checkov:skip=CKV_AWS_273:Service users with no console or key are part of the demo. Human access goes through the roles in iam_custom_role.
  for_each = { for iam_user in var.iam_user : iam_user.name => iam_user }

  name          = each.value.name
  path          = "/"
  force_destroy = false
}

resource "aws_iam_user_policy_attachment" "iam_user_policy_attach" {
  #checkov:skip=CKV_AWS_40:Direct attachment mirrors the original per-user boundary policy. Group attachment is shown in the iam_group module.
  for_each = {
    for user_policy in flatten([
      for user in var.iam_user : [
        for index, policy in user.policy : {
          key        = "${user.name}-${index}"
          user_name  = user.name
          policy_arn = policy
        }
      ]
    ]) : user_policy.key => user_policy
  }

  user       = aws_iam_user.iam_user[each.value.user_name].name
  policy_arn = each.value.policy_arn
}
