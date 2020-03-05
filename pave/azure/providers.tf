terraform {
  required_version = ">= 0.12"
}

provider "null" {
  version = "~> 2.1.0"
}

provider "random" {
  version = "~> 2.2.0"
}

provider "tls" {
  version = "~> 2.1.0"
}

provider "template" {
  version = "~> 2.1.0"
}