data "aws_region" "current" {}

locals {
  name   = "challenge-vpc"
  region = "eu-west-1"

}

module "main_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.2.0"

  name = local.name
  cidr = "10.0.0.0/16"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_security_group" "main_vpc_endpoint_sg" {
  name        = "main-vpc-endpoint-sg"
  description = "Allow all"
  vpc_id      = module.main_vpc.vpc_id

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = module.main_vpc.vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = flatten([
    module.main_vpc.private_route_table_ids,
    module.main_vpc.public_route_table_ids
  ])


  tags = {
    Name        = "s3-endpoint"
    Environment = "dev"
  }
}

resource "aws_vpc_endpoint" "dkr" {
  vpc_id              = module.main_vpc.vpc_id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  security_group_ids = [
    aws_security_group.main_vpc_endpoint_sg.id,
  ]
  subnet_ids = module.main_vpc.private_subnets

  tags = {
    Name        = "dkr-endpoint"
    Environment = "dev"
  }
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id              = module.main_vpc.vpc_id
  private_dns_enabled = true
  service_name        = "com.amazonaws.${data.aws_region.current.name}.logs"
  vpc_endpoint_type   = "Interface"
  security_group_ids = [
    aws_security_group.main_vpc_endpoint_sg.id,
  ]
  subnet_ids = module.main_vpc.private_subnets

  tags = {
    Name        = "logs-endpoint"
    Environment = "dev"
  }
}
