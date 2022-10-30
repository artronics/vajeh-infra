variable "permanent_environments" {
  default = ["dev"]
}

locals {
  root_domain = "artronics.me.uk"
  project_domain = "${local.root_project}.${local.root_domain}"
}

