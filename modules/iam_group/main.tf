resource "aws_iam_group" "group" {
  for_each = { for iam_group in var.iam_group : iam_group.name => iam_group }

  name = each.value.name
  path = "/"
}

resource "aws_iam_group_policy_attachment" "iam_group_policy_attach" {
  for_each = {
    for group_policy in flatten([
      for group in var.iam_group : [
        for index, policy in group.policy : {
          key        = "${group.name}-${index}"
          group_name = group.name
          policy_arn = policy
        }
      ]
    ]) : group_policy.key => group_policy
  }

  group      = aws_iam_group.group[each.value.group_name].name
  policy_arn = each.value.policy_arn
}

resource "aws_iam_user_group_membership" "iam_user_group_attach" {
  for_each = {
    for group_user in flatten([
      for group in var.iam_group : [
        for user in group.users : {
          group_name = group.name
          user_name  = user
        }
      ]
    ]) : "${group_user.group_name}-${group_user.user_name}" => group_user
  }

  user   = each.value.user_name
  groups = [aws_iam_group.group[each.value.group_name].name]
}
