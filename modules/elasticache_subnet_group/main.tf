resource "aws_elasticache_subnet_group" "subnet_group" {
  for_each = { for group in var.elasticache_subnet_group : group.name => group }

  name       = each.value.name
  subnet_ids = each.value.subnets
}
