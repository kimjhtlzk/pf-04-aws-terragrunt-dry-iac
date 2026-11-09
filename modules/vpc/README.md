# vpc

Creates VPCs and subnets from one list, closes the default security group, and turns on VPC Flow Logs.

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
| [aws_cloudwatch_log_group.flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_flow_log.flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_role.flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_subnet.subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_iam_policy_document.flow_log_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.flow_log_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| flow\_log\_retention\_days | How long to keep VPC Flow Logs in CloudWatch. | `number` | `365` | no |
| vpcs | VPCs to create, each with its subnets. | ```list(object({ name = string cidr_block = string use_ipv6_cidr_block = bool subnets = list(object({ subnet_name = string subnet_cidr = string ipv6_cidr_block = string availability_zone = string autoassign_public = bool tags = map(string) })) }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| subnets | Subnet objects, keyed by availability zone and CIDR. |
| subnets\_ids | Subnet IDs, keyed by subnet name. |
| vpc\_id | VPC ID and CIDR, keyed by VPC name. |
| vpc\_ipv6\_cidr\_block | IPv6 CIDR of each VPC, keyed by VPC name. |
<!-- END_TF_DOCS -->
