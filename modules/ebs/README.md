# ebs

Creates standalone encrypted EBS volumes.

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
| [aws_ebs_volume.ebs_volume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| ebs | EBS volumes to create. Set snapshot\_id, iops, and throughput to null to use defaults. | ```list(object({ name = string availability_zone = string type = string size = number snapshot_id = string iops = number throughput = number device_name = string }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| ebs\_arn | Volume ARNs, keyed by volume name. |
| ebs\_id | Volume IDs, keyed by volume name. |
<!-- END_TF_DOCS -->
