locals {
  root_auth_domain_name = "auth.${local.project_domain}"
}

# AWS Cognito needs a root record that is reachable. We just use a dummy IP address
resource "aws_route53_record" "auth_root_domain_dummy" {
  zone_id = aws_route53_zone.project_zone.zone_id
  name    = local.root_auth_domain_name
  type    = "A"
  ttl     = 300
  records = ["127.0.0.1"]  # Placeholder that is never used. See: https://stackoverflow.com/a/56429359/3943054
}

