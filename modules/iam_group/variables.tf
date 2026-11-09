variable "iam_group" {
  description = "Groups to create, with attached policy ARNs and member user names."
  type = list(object({
    name   = string
    policy = list(string)
    users  = list(string)
  }))
}
