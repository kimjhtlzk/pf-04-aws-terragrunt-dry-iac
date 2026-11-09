# Everything every unit needs is generated from here: backend, provider, common inputs.
locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  account_name = local.account_vars.locals.account_name
  aws_region   = local.region_vars.locals.aws_region
}

# Local state keeps the demo free of any cloud dependency.
# For a team, switch to S3 with DynamoDB locking:
#
# remote_state {
#   backend = "s3"
#   config = {
#     bucket         = "example-terraform-state"
#     key            = "${path_relative_to_include()}/terraform.tfstate"
#     region         = "ap-northeast-2"
#     encrypt        = true
#     dynamodb_table = "example-terraform-lock"
#   }
#   generate = {
#     path      = "backend.tf"
#     if_exists = "overwrite_terragrunt"
#   }
# }
remote_state {
  backend = "local"
  config = {
    path = "${get_parent_terragrunt_dir()}/.state/${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<PROVIDER
provider "aws" {
  region = "${local.aws_region}"

  default_tags {
    tags = {
      Environment = "${local.account_name}"
      ManagedBy   = "terragrunt"
    }
  }
}
PROVIDER
}

inputs = merge(local.account_vars.locals, local.region_vars.locals)
