variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "private_subnet_ids" {
  description = "Privates subnet ids"
  type        = list(string)
}

variable "dynamodb_table_arn" {
  description = "Dynamodb table arn"
  type        = string
}

variable "alb_target_group_arn" {
  description = "Alb target group arn"
  type        = string
}

variable "alb_security_group_id" {
  description = "Alb security group id"
  type        = string
}

variable "application_port" {
  description = "Port on which the application is listening."
  type        = number
  default     = 3000
}

variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
}

variable "vpc_id" {
  description = "Vpc ids"
  type        = string
}

variable "secret_name" {
  description = "SecretManager secret name"
  type        = string
}
