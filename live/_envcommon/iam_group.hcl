terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../modules//iam_group"
}

dependency "iam_custom_policy" {
  config_path = "${get_terragrunt_dir()}/../iam_custom_policy"

  mock_outputs = {
    policy_arn = { "office-ip-guard" = "arn:aws:iam::111111111111:policy/office-ip-guard" }
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

dependency "iam_user" {
  config_path = "${get_terragrunt_dir()}/../iam_user"

  mock_outputs = {
    user_names = { "demo-user-1" = "demo-user-1" }
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}
