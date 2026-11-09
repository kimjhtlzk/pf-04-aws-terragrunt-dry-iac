# nat_gateway

Creates public NAT gateways with a fixed private IP.

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
| [aws_nat_gateway.ngw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| ngw | NAT gateways to create. subnets is a single subnet ID. | ```list(object({ name = string eip = string subnets = string private_ip = string }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| ngw\_id | NAT gateway IDs, keyed by name. |
<!-- END_TF_DOCS -->
