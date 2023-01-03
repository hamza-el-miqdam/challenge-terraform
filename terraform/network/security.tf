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
