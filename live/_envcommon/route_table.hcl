terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../modules//route_table"
}

dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../vpc"

  mock_outputs = {
    vpc_id = {
      "demo-vpc-1" = { vpc_cidr = "10.0.0.0/16", vpc_id = "vpc-00000000000000001" }
      "demo-vpc-2" = { vpc_cidr = "10.1.0.0/16", vpc_id = "vpc-00000000000000002" }
    }
    subnets_ids = {
      "demo-vpc-1-subnet-1" = "subnet-00000000000000001"
      "demo-vpc-1-subnet-2" = "subnet-00000000000000002"
      "demo-vpc-2-subnet-1" = "subnet-00000000000000003"
    }
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "internet_gateway" {
  config_path = "${get_terragrunt_dir()}/../internet_gateway"

  mock_outputs = {
    igw_id = { "igw-demo-vpc-1" = "igw-00000000000000001" }
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "nat_gateway" {
  config_path = "${get_terragrunt_dir()}/../nat_gateway"

  mock_outputs = {
    ngw_id = { "ngw-demo-vpc-1" = "nat-00000000000000001" }
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "vpc_peering" {
  config_path = "${get_terragrunt_dir()}/../vpc_peering"

  mock_outputs = {
    vpc_peering_id = { "demo-peer-01" = "pcx-00000000000000001" }
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}
