variable "users" {
  type = list(object({
    username       = string,
    short_username = string,
    roles          = set(string)
  }))
}

variable "permanent_environments" {
  default = ["dev"]
}

variable "pr_environments" {
  default = ["pr*"]
}

locals {
  developers_environments = [for dev in var.users : dev.short_username if contains(dev.roles, "Developer")]
  temporary_environments = concat(var.pr_environments, local.developers_environments)
}

locals {
  root_domain = "artronics.me.uk"
  project_domain = "${local.root_project}.${local.root_domain}"
}

