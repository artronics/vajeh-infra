output "policies" {
  value = flatten(local.s3_polices)
}
