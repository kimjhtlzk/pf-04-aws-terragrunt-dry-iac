variable "iam_role" {
  description = "Roles to create. assume_role_policy is a JSON document."
  type = list(object({
    name               = string
    attach_policy      = list(string)
    assume_role_policy = string
  }))
}
