resource "aws_eip" "eip" {
  #checkov:skip=CKV2_AWS_19:Modules are scanned alone. The association happens in ec2_instance and nat_gateway through Terragrunt dependencies.
  for_each = { for eip in var.eip : eip.name => eip }

  domain = "vpc"

  tags = {
    Name = each.value.name
  }
}
