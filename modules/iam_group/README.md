# iam_group

Creates IAM groups, attaches policies, and adds members.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| terraform | >= 1.9, < 2.0 |
| aws | ~> 5.57 |

## Providers

| Name | Version |
| ---- | ------- |
| aws | ~> 5.57 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_iam_group.group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.iam_group_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_user_group_membership.iam_user_group_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| iam\_group | Groups to create, with attached policy ARNs and member user names. | ```list(object({ name = string policy = list(string) users = list(string) }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| group\_names | Group names. |
<!-- END_TF_DOCS -->
