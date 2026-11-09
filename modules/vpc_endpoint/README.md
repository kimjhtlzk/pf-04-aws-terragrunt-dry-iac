# vpc_endpoint

Creates S3 gateway endpoints.

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
| [aws_vpc_endpoint.ep](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| eps | S3 gateway endpoints to create. Each VPC can appear once. | ```list(object({ name = string vpc = string region = string }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| endpoint\_ids | Endpoint IDs, keyed by VPC ID. |
<!-- END_TF_DOCS -->
