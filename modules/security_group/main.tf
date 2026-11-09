locals {
  ingress_rules_flat = flatten([for sg in var.security_group : [for rule in sg.ingress_rules : merge(rule, { sg_name : sg.name })]])
  egress_rules_flat  = flatten([for sg in var.security_group : [for rule in sg.egress_rules : merge(rule, { sg_name : sg.name })]])
}

resource "aws_security_group" "sg" {
  #checkov:skip=CKV2_AWS_5:Modules are scanned alone. The attachment happens in ec2_instance through the Terragrunt dependency.
  for_each = { for security_group in var.security_group : security_group.name => security_group }

  name        = each.value.name
  description = "Managed by Terragrunt: ${each.value.name}"
  vpc_id      = each.value.vpc

  tags = {
    Name = each.value.name
  }
}

resource "aws_security_group_rule" "ingress_rules" {
  for_each = { for rule in local.ingress_rules_flat : rule.rule_name => rule }

  type              = "ingress"
  description       = each.value.rule_name
  from_port         = split("-", each.value.port_range[0])[0]
  to_port           = split("-", each.value.port_range[0])[1]
  protocol          = each.value.protocol
  cidr_blocks       = split(",", each.value.cidr_blocks)
  security_group_id = aws_security_group.sg[each.value.sg_name].id
}

resource "aws_security_group_rule" "egress_rules" {
  for_each = { for rule in local.egress_rules_flat : rule.rule_name => rule }

  type              = "egress"
  description       = each.value.rule_name
  from_port         = split("-", each.value.port_range[0])[0]
  to_port           = split("-", each.value.port_range[0])[1]
  protocol          = each.value.protocol
  cidr_blocks       = split(",", each.value.cidr_blocks)
  security_group_id = aws_security_group.sg[each.value.sg_name].id
}
