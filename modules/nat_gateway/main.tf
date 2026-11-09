resource "aws_nat_gateway" "ngw" {
  for_each = { for ngw in var.ngw : ngw.name => ngw }

  allocation_id     = each.value.eip
  subnet_id         = each.value.subnets
  private_ip        = each.value.private_ip
  connectivity_type = "public"

  tags = {
    Name = each.value.name
  }
}
