# ec2_instance

Creates EC2 instances with a fixed-IP network interface, optional Elastic IP, and additional EBS volumes. IMDSv2 and encryption are always on.

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
| [aws_ebs_volume.ebs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_eip_association.eip_att](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_instance.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_network_interface.nic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_volume_attachment.ebs_att](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| ec2\_instance | EC2 instances to create. | ```list(object({ name = string ami = string instance_type = string availability_zone = string subnet = string private_ip = string associate_public_ip_address = string security_groups = list(string) spot_options = object({ use_spot = bool instance_interruption_behavior = string spot_instance_type = string max_price = number }) root_ebs = object({ root_ebs_type = string root_ebs_size = number delete_on_termination = bool }) add_ebs = map(object({ add_ebs_type = string add_ebs_size = number add_ebs_path = string iops = number throughput = number snapshot_id = string ebs_id = string })) iam_instance_profile = string disable_api_termination = bool }))``` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| instance\_ids | Instance IDs, keyed by instance name. |
| private\_ips | Private IPs, keyed by instance name. |
<!-- END_TF_DOCS -->
