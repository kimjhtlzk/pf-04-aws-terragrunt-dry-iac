locals {
  subnets = flatten([
    for vpc in var.vpcs : [
      for subnet in vpc.subnets : {
        vpc_cidr = vpc.cidr_block
        subnet   = subnet
      }
    ]
  ])
}

resource "aws_vpc" "vpc" {
  for_each = { for vpc in var.vpcs : vpc.cidr_block => vpc }

  cidr_block                       = each.key
  assign_generated_ipv6_cidr_block = each.value.use_ipv6_cidr_block
  enable_dns_hostnames             = true

  tags = {
    Name = each.value.name
  }
}

resource "aws_subnet" "subnet" {
  for_each = { for subnet in local.subnets : "${subnet.subnet.availability_zone}-${subnet.subnet.subnet_cidr}" => subnet }

  vpc_id                  = aws_vpc.vpc[each.value.vpc_cidr].id
  cidr_block              = each.value.subnet.subnet_cidr
  ipv6_cidr_block         = each.value.subnet.ipv6_cidr_block
  availability_zone       = each.value.subnet.availability_zone
  map_public_ip_on_launch = each.value.subnet.autoassign_public

  tags = merge({ Name = each.value.subnet.subnet_name }, each.value.subnet.tags)
}

# No rules on purpose: the default security group denies everything.
resource "aws_default_security_group" "default" {
  for_each = { for vpc in var.vpcs : vpc.cidr_block => vpc }

  vpc_id = aws_vpc.vpc[each.key].id

  tags = {
    Name = "${each.value.name}-default-sg"
  }
}

resource "aws_cloudwatch_log_group" "flow_log" {
  #checkov:skip=CKV_AWS_158:Uses the CloudWatch service key so the demo has no KMS dependency. Add kms_key_id in production.
  for_each = { for vpc in var.vpcs : vpc.cidr_block => vpc }

  name              = "/vpc/flow-log/${each.value.name}"
  retention_in_days = var.flow_log_retention_days
}

data "aws_iam_policy_document" "flow_log_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "flow_log_write" {
  for_each = aws_cloudwatch_log_group.flow_log

  statement {
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents", "logs:DescribeLogStreams"]
    resources = ["${each.value.arn}:*"]
  }
}

resource "aws_iam_role" "flow_log" {
  for_each = aws_cloudwatch_log_group.flow_log

  name_prefix        = "vpc-flow-log-"
  assume_role_policy = data.aws_iam_policy_document.flow_log_assume.json
}

resource "aws_iam_role_policy" "flow_log" {
  for_each = aws_cloudwatch_log_group.flow_log

  role   = aws_iam_role.flow_log[each.key].id
  policy = data.aws_iam_policy_document.flow_log_write[each.key].json
}

resource "aws_flow_log" "flow_log" {
  for_each = aws_cloudwatch_log_group.flow_log

  vpc_id          = aws_vpc.vpc[each.key].id
  traffic_type    = "ALL"
  iam_role_arn    = aws_iam_role.flow_log[each.key].arn
  log_destination = each.value.arn
}
