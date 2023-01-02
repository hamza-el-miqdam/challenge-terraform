locals {
  app_name = "bookstore"
}

module "registry" {
  source = "./registry"

  app_name = local.app_name
}

module "secret-manager" {
  source = "./secret-manager"

  app_name = local.app_name
}
