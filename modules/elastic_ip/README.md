# elastic_ip

Allocates VPC Elastic IPs.

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
| [aws_eip.eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| eip | Elastic IPs to allocate. | ```list(object({ name = string }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| eip\_id | Allocation IDs, keyed by name. |
<!-- END_TF_DOCS -->
