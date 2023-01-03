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