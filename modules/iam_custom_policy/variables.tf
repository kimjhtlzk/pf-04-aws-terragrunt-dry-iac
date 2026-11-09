variable "iam_policy" {
  description = "Policies to create. policy is a JSON document."
  type = list(object({
    name   = string
    policy = string
  }))
}
