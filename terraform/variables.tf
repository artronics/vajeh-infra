variable "project" {
  description = "Project name. It should be the same as repo name. The value comes from PROJECT in .env file."
}

variable "account_name" {
  description = "Account name; ptl or live"
}

variable "root_aws_access_key_id" {
  sensitive=true
}
variable "root_aws_secret_access_key" {
  sensitive=true
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
  root_domain = "vajeh.co.uk"
}

