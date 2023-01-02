module "main_acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "3.2.1"

  domain_name = aws_route53_record.main.name
  zone_id     = aws_route53_record.main.zone_id
}
