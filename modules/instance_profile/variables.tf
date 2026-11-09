variable "instance_profile" {
  description = "Instance profiles to create, each bound to a role name."
  type = list(object({
    name = string
    role = string
  }))
}
