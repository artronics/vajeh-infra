variable "user" {
  type = object({
    shortname = string
    groups = set(string)
  })
}

variable "name_prefix" {
  type = string
}
