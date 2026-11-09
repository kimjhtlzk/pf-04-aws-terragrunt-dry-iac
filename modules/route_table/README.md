# route_table

Creates route tables with IGW, NAT, or peering routes and associates subnets.

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
| [aws_route_table.route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.route_table_att](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| route\_table | Route tables to create. resource\_type is igw, ngw, or peering. | ```list(object({ name = string vpc = string subnets = list(string) rule = map(object({ cidr_block = string resource_type = string resource_name = string })) }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| route\_table\_ids | Route table IDs, keyed by name. |
<!-- END_TF_DOCS -->
