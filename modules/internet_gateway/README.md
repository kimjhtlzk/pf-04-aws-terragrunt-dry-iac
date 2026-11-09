# internet_gateway

Creates internet gateways and attaches them to VPCs.

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
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_internet_gateway_attachment.igw_att](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| igw | Internet gateways to create. Set vpc to null to leave one detached. | ```list(object({ name = string vpc = string }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| igw\_id | Gateway IDs, keyed by name. |
<!-- END_TF_DOCS -->
