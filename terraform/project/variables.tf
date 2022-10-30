variable "root_project" {}
variable "permanent_environments" {
  type = set(string)
}

variable "project" {
  type = object({
    name = string
    developers = set(string)
    policies = set(string)
  })
}

locals {
  name_prefix = "${var.root_project}-${var.project.name}"
}
