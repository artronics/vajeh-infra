output "policies" {
  value = concat(local.s3_polices, local.secretsmanager_polices)
}
