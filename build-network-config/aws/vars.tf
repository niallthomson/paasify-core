variable "vpc_cidr" {}

variable "subnet_ids" {
  type = list(string)
}

variable "subnet_cidrs" {
  type = list(string)
}

variable "subnet_azs" {
  type = list(string)
}