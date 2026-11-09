terraform {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/../modules//iam_custom_role"
}

dependency "iam_custom_policy" {
  config_path = "${get_terragrunt_dir()}/../iam_custom_policy"

  mock_outputs = {
    policy_arn = { "office-ip-guard" = "arn:aws:iam::111111111111:policy/office-ip-guard" }
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}
