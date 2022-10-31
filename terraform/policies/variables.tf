variable "root_project" {}
variable "project_name" {}

locals {
  project_prefix = "${var.root_project}-${var.project_name}"
}

variable "exclude_envs" {
  type    = set(string)
  default = ["*"]
}
variable "include_envs" { type = set(string) }

variable "services" { type = set(string) }
