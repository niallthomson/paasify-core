terraform {
  required_version = ">= 0.14"

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 2.2.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 2.1.0"
    }

    template = {
      source  = "hashicorp/template"
      version = "~> 2.1.0"
    }
  }
}