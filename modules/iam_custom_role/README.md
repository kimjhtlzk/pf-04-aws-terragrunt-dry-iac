# iam_custom_role

Creates IAM roles and attaches policies to them.

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
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| iam\_role | Roles to create. assume\_role\_policy is a JSON document. | ```list(object({ name = string attach_policy = list(string) assume_role_policy = string }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| role\_arn | Role ARNs, keyed by role name. |
<!-- END_TF_DOCS -->
