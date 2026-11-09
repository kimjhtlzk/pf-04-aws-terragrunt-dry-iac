# iam_custom_policy

Creates customer-managed IAM policies.

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
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| iam\_policy | Policies to create. policy is a JSON document. | ```list(object({ name = string policy = string }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| policy\_arn | Policy ARNs, keyed by policy name. |
<!-- END_TF_DOCS -->
