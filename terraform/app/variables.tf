variable "vpc_id" {
  description = "Vpc ids"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet ids"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnet ids"
  type        = list(string)
}

variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
}

variable "secret_name" {
  description = "SecretManager secret name"
  type        = string
}

variable "route53_zone_name" {
  description = "Route53 zone name"
  type        = string
}

variable "alerting_email" {
  description = "Email to send alerts too"
  type        = string
}
