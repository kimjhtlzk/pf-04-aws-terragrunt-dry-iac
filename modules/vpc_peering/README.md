# vpc_peering

Creates VPC peering connections inside or across accounts and regions.

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
| [aws_vpc_peering_connection.vpc_peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| vpc\_peer | Peering connections to create. peer\_type is internal or external. | ```list(object({ peer_type = string target_project_id = string name = string vpc = string target_vpc = string other_region = string accepter_dns_resolution = bool requester_dns_resolution = bool }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| vpc\_peering\_id | Peering connection IDs, keyed by name. |
<!-- END_TF_DOCS -->
