variable "project" {
  description = "Project name. It should be the same as repo name. The value comes from PROJECT in .env file."
}

variable "account_name" {
  description = "Account name; ptl or live"
}

variable "root_aws_access_key_id" {
  sensitive = true
}

variable "root_aws_secret_access_key" {
  sensitive = true
}

