variable "subnet_name" {} 

variable "network_name" {} 

variable "region" {} 

variable "subnet_cidr" {} 

variable "subnet_gateway" {} 

variable "subnet_azs" {
  type = list(string)
}