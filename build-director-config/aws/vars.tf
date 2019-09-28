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