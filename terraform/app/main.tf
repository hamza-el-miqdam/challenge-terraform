locals {
  app_name         = "bookstore"
  table_name       = "books"
  application_port = 3000
}

module "dynamodb" {
  source     = "./dynamodb"
  table_name = local.table_name
}

module "alb" {
  source = "./alb"

  app_name          = local.app_name
  public_subnet_ids = var.public_subnet_ids
  vpc_id            = var.vpc_id
  application_port  = local.application_port
  route53_zone_name = var.route53_zone_name
}

module "ecs" {
  source = "./ecs"

  app_name              = local.app_name
  private_subnet_ids    = var.private_subnet_ids
  dynamodb_table_arn    = module.dynamodb.dynamodb_table_arn
  alb_target_group_arn  = module.alb.alb_target_group_arn
  alb_security_group_id = module.alb.alb_security_group_id
  application_port      = local.application_port
  ecr_repository_name   = var.ecr_repository_name
  vpc_id                = var.vpc_id
  secret_name           = var.secret_name
  alerting_email        = var.alerting_email

  depends_on = [
    module.alb,
    module.dynamodb
  ]
}
