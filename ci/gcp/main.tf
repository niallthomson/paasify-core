provider "google" {
  project = "fe-nthomson"
  region  = "us-central1"

  version = "~> 3.9.0"
}

module "pave" {
  source = "../../pave/gcp"

  environment_name = "test123"
  project          = "fe-nthomson"

  region             = "us-central1"
  availability_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]

  dns_suffix  = "gcp.paasify.org"
  hosted_zone = "paasify-zone"

  ops_manager_version = "2.8.2"
  ops_manager_build   = "203"

  pivnet_token = "mytoken123"
}