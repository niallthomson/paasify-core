provider "aws" {
  region = "us-west-2"

  version = "~> 2.50.0"
}

module "pave" {
  source = "../../pave/aws"

  environment_name = "test123"
  region           = "us-west-2"

  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]

  dns_suffix = "aws.paasify.org"

  ops_manager_version = "2.8.2"
  ops_manager_build   = "203"

  pivnet_token = "mytoken123"
}