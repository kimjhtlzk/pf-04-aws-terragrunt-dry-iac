# iam_user

Creates IAM users with no console password or access key.

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
| [aws_iam_user.iam_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.iam_user_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| iam\_user | Users to create, with directly attached policy ARNs. | ```list(object({ name = string policy = list(string) }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| user\_names | User names. |
<!-- END_TF_DOCS -->
