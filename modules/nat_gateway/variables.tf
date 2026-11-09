variable "ngw" {
  description = "NAT gateways to create. subnets is a single subnet ID."
  type = list(object({
    name       = string
    eip        = string
    subnets    = string
    private_ip = string
  }))
}
