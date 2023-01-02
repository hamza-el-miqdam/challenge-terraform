variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet ids"
  type        = list(string)
}

variable "vpc_id" {
  description = "Vpc ids"
  type        = string
}

variable "application_port" {
  description = "Port on which the application is listening."
  type        = number
  default     = 3000
}

variable "route53_zone_name" {
  description = "Route53 zone name"
  type        = string
}
