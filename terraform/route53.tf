data "aws_route53_zone" "root_zone" {
  provider = aws.root
  name = "vajeh.co.uk"
}

locals {
  project_zone_name = "${var.account_name}.${data.aws_route53_zone.root_zone.name}"
}

resource "aws_route53_zone" "project_zone" {
  provider = aws.ptl
  name = local.project_zone_name
}

resource "aws_route53_record" "project_ns_record" {
  provider = aws.root

  name    = local.project_zone_name
  type    = "NS"
  ttl     = 172800
  zone_id = data.aws_route53_zone.root_zone.zone_id
  records = aws_route53_zone.project_zone.name_servers
}
