output "main_vpc_id" {
  description = "Main VPC ID"
  value       = module.main_vpc.vpc_id
}

output "main_subnet_ids" {
  description = "Main Subnet IDs, grouped by tier"
  value = {
    private : module.main_vpc.private_subnets,
    public : module.main_vpc.public_subnets,
  }
}
