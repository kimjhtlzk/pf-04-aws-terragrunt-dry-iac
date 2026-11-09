variable "iam_user" {
  description = "Users to create, with directly attached policy ARNs."
  type = list(object({
    name   = string
    policy = list(string)
  }))
}
