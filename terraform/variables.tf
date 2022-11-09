variable "root_aws_access_key" {
  sensitive=true
}
variable "root_aws_secret_key" {
  sensitive=true
}

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

variable "ptl_environments" {
  default = ["ptl"]
}

locals {
  developers_environments = [for dev in var.users : dev.short_username if contains(dev.roles, "Developer")]
  temporary_environments = concat(var.pr_environments, local.developers_environments)
}

locals {
  root_domain = "vajeh.co.uk"
}

