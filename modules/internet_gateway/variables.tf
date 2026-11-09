variable "igw" {
  description = "Internet gateways to create. Set vpc to null to leave one detached."
  type = list(object({
    name = string
    vpc  = string
  }))
}
