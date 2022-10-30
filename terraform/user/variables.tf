variable "username_prefix" {}
locals {
  name_prefix = var.username_prefix
}

variable "user" {
  type = object({
    username       = string
    short_username = string
    roles          = set(string)
  })

  validation {
    condition     = length([
      for role in var.user.roles : true if contains([
        "Developer", "Admin"
      ], role)
    ]) == length(var.user.roles)
    error_message = "Invalid role"
  }
}

