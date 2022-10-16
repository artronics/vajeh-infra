variable "project" {
  type = object({
    name = string,
    pipeline_existing_policies = list(string)
  })
}

variable "pipeline_group_name" {
   type = string
}
