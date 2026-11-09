terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../modules//nat_gateway"
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

dependency "elastic_ip" {
  config_path = "${get_terragrunt_dir()}/../elastic_ip"

  mock_outputs = {
    eip_id = {
      "demo-eip-1" = "eipalloc-00000000000000001"
      "demo-eip-2" = "eipalloc-00000000000000002"
    }
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}
