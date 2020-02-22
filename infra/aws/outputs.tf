output "environment_name" {
  value = var.environment_name
}

output "availability_zones" {
  value = var.availability_zones
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "base_domain" {
  value = local.base_domain
}

output "dns_zone_id" {
  value = aws_route53_zone.zone.id
}

output "vpc_cidr" {
  value = var.vpc_cidr
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}

output "public_subnet_availability_zones" {
  value = aws_subnet.public_subnet.*.availability_zone
}

output "public_subnet_cidrs" {
  value = aws_subnet.public_subnet.*.cidr_block
}

output "management_subnet_ids" {
  value = aws_subnet.management_subnet.*.id
}

output "management_subnet_availability_zones" {
  value = aws_subnet.management_subnet.*.availability_zone
}

output "management_subnet_cidrs" {
  value = aws_subnet.management_subnet.*.cidr_block
}

output "initial_net_num" {
  description = "The initial netnum parameter that should be used to create additional subnets so as to not overlap"
  value       = 2
}

output "ops_manager_bucket" {
  value = aws_s3_bucket.ops_manager_bucket.bucket
}

output "bucket_suffix" {
  value = random_integer.bucket_suffix.result
}

output "ops_manager_iam_instance_profile_name" {
  value = aws_iam_instance_profile.ops_manager.name
}

output "ops_manager_iam_user_name" {
  value = aws_iam_user.ops_manager.name
}

output "ops_manager_iam_user_access_key" {
  value = aws_iam_access_key.ops_manager.id
}

output "ops_manager_iam_user_secret_key" {
  value     = aws_iam_access_key.ops_manager.secret
  sensitive = true
}

output "vms_security_group_id" {
  value = aws_security_group.ops_manager.id
}

output "ops_manager_ssh_private_key" {
  value = tls_private_key.ops_manager.private_key_pem
}

output "ops_manager_ssh_public_key_name" {
  value = aws_key_pair.ops_manager.key_name
}

output "ops_manager_domain" {
  value = local.om_domain
}