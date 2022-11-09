variable "root_project" {}

variable "environments" {
  type = object({
    pr_environments        = list(string)
    developer_environments = list(string)
    permanent_environments = list(string)
  })
}

variable "project" {
  type = object({
    name               = string
    developers         = set(string)
    developer_policies = list(string)
    pipeline_policies  = list(string)
  })
}

locals {
  name_prefix = "${var.root_project}-${var.project.name}"
}
