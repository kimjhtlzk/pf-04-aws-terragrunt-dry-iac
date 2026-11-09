variable "eps" {
  description = "S3 gateway endpoints to create. Each VPC can appear once."
  type = list(object({
    name   = string
    vpc    = string
    region = string
  }))
}
