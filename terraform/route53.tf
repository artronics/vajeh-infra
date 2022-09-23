data "aws_route53_zone" "root_zone" {
  name = local.root_domain
}

locals {
  project_zone_name = "${local.root_project}.${data.aws_route53_zone.root_zone.name}"
}

resource "aws_route53_zone" "project_zone" {
  name = local.project_zone_name
}

resource "aws_route53_record" "project_ns_record" {
  name    = local.project_zone_name
  type    = "NS"
  ttl     = 172800
  zone_id = data.aws_route53_zone.root_zone.zone_id
  records = data.aws_route53_zone.root_zone.name_servers
}
