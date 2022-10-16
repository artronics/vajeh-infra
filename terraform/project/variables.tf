variable "project" {
  type = object({
    name = string,
    aws_policies = set(string)
  })
}

variable "default_aws_policies" {
  type = set(string)
}
