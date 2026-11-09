# elasticache_subnet_group

Creates ElastiCache subnet groups.

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
| [aws_elasticache_subnet_group.subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| elasticache\_subnet\_group | Subnet groups to create. | ```list(object({ name = string subnets = list(string) }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| subnet\_group\_name | Subnet group names. |
<!-- END_TF_DOCS -->
