variable "route_table" {
  description = "Route tables to create. resource_type is igw, ngw, or peering."
  type = list(object({
    name    = string
    vpc     = string
    subnets = list(string)
    rule = map(object({
      cidr_block    = string
      resource_type = string
      resource_name = string
    }))
  }))
}
