terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../modules//instance_profile"
}

dependency "iam_custom_role" {
  config_path = "${get_terragrunt_dir()}/../../global/iam_custom_role"

  mock_outputs = {
    role_arn = { "ec2-readonly" = "arn:aws:iam::111111111111:role/ec2-readonly" }
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}
