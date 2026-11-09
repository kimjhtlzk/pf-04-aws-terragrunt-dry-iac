# security_group

Creates security groups from a rule map. CIDRs are comma separated and ports are written as from-to.

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
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| security\_group | Security groups to create with ingress and egress rule maps. | ```list(object({ name = string vpc = string ingress_rules = map(object({ rule_name = string cidr_blocks = string protocol = string port_range = list(string) })) egress_rules = map(object({ rule_name = string cidr_blocks = string protocol = string port_range = list(string) })) }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| security\_group\_ids | Security group IDs, keyed by name. |
<!-- END_TF_DOCS -->
