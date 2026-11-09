variable "eip" {
  description = "Elastic IPs to allocate."
  type = list(object({
    name = string
  }))
}
