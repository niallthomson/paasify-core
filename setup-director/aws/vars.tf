variable "env_name" {

}

variable "provisioner_subnet_id" {
  description = "The VPC Subnet ID to launch in."
}

variable "dns_zone_id" {
  description = "The Route53 Zone ID to place the DNS record"
}

variable "pivnet_token" {
  description = "Your API token for Pivotal Network"
}

variable "om_host" {
  description = "The OpsManager host to use for API calls"
}

variable "azs" {
  type = list(string)
}

variable "iam_instance_profile" {} 
variable "vpc_id" {} 
variable "security_group" {} 
variable "key_pair_name" {} 
variable "ssh_private_key" {} 
variable "region" {} 
variable "bucket_name" {} 
variable "bucket_access_key_id" {} 
variable "bucket_secret_access_key" {} 
variable "ebs_encryption" {
  default = true
}

variable "vpc_cidr" {} 

variable "management_subnet_ids" {
  type = list(string)
} 

variable "management_subnet_cidrs" {
  type = list(string)
} 

variable "management_subnet_azs" {
  type = list(string)
} 

variable "director_ops_file" {
  description = "Optional ops file yml for director tile"
  default     = ""
}

variable "additional_cert_domains" {
  type    = list(string)
  default = []
}

variable "secrets" {
  type    = map(string)
  default = {}
}

variable "blocker" {
  description = "Used to link to a blocker resource"
  default = ""
}