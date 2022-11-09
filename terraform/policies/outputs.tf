output "policies" {
  value = concat(local.s3_polices, local.secretsmanager_polices, local.cognito_userpool_polices)
}
