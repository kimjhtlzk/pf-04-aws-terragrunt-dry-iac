# instance_profile

Creates EC2 instance profiles.

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
| [aws_iam_instance_profile.instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| instance\_profile | Instance profiles to create, each bound to a role name. | ```list(object({ name = string role = string }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| instance\_profile\_arn | Instance profile ARNs, keyed by name. |
<!-- END_TF_DOCS -->
