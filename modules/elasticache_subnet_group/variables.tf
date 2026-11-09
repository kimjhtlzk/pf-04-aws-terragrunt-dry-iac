variable "elasticache_subnet_group" {
  description = "Subnet groups to create."
  type = list(object({
    name    = string
    subnets = list(string)
  }))
}
