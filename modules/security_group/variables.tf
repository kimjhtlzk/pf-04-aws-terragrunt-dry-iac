variable "security_group" {
  description = "Security groups to create with ingress and egress rule maps."
  type = list(object({
    name = string
    vpc  = string
    ingress_rules = map(object({
      rule_name   = string
      cidr_blocks = string
      protocol    = string
      port_range  = list(string)
    }))
    egress_rules = map(object({
      rule_name   = string
      cidr_blocks = string
      protocol    = string
      port_range  = list(string)
    }))
  }))
}
