include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "envcommon" {
  path           = "${dirname(find_in_parent_folders("root.hcl"))}/_envcommon/iam_custom_role.hcl"
  merge_strategy = "deep"
}

locals {
  account_id = read_terragrunt_config(find_in_parent_folders("account.hcl")).locals.aws_account_id
}

inputs = {
  iam_role = [
    {
      name          = "owner"
      attach_policy = ["arn:aws:iam::aws:policy/AdministratorAccess"]
      assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
          Effect    = "Allow"
          Principal = { AWS = ["arn:aws:iam::${local.account_id}:user/example-owner"] }
          Action    = "sts:AssumeRole"
          Condition = { Bool = { "aws:MultiFactorAuthPresent" = "true" } }
        }]
      })
    },
    {
      name = "admin"
      attach_policy = [
        "arn:aws:iam::aws:policy/IAMFullAccess",
        "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
        "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
      ]
      assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
          Effect    = "Allow"
          Principal = { AWS = ["arn:aws:iam::${local.account_id}:user/example-admin-1", "arn:aws:iam::${local.account_id}:user/example-admin-2"] }
          Action    = "sts:AssumeRole"
          Condition = { Bool = { "aws:MultiFactorAuthPresent" = "true" } }
        }]
      })
    },
    {
      name          = "security-engineer"
      attach_policy = ["arn:aws:iam::aws:policy/SecurityAudit"]
      assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
          Effect    = "Allow"
          Principal = { AWS = ["arn:aws:iam::${local.account_id}:user/example-security-1"] }
          Action    = "sts:AssumeRole"
          Condition = { Bool = { "aws:MultiFactorAuthPresent" = "true" } }
        }]
      })
    },
    {
      name          = "dba"
      attach_policy = []
      assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
          Effect    = "Allow"
          Principal = { AWS = ["arn:aws:iam::${local.account_id}:user/example-dba-1"] }
          Action    = "sts:AssumeRole"
          Condition = { Bool = { "aws:MultiFactorAuthPresent" = "true" } }
        }]
      })
    },
    {
      name          = "ec2-readonly"
      attach_policy = ["arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"]
      assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
          Effect    = "Allow"
          Principal = { Service = "ec2.amazonaws.com" }
          Action    = "sts:AssumeRole"
        }]
      })
    },
    {
      name          = "eks-cluster-role"
      attach_policy = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
      assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
          Effect    = "Allow"
          Principal = { Service = "eks.amazonaws.com" }
          Action    = "sts:AssumeRole"
        }]
      })
    },
  ]
}
