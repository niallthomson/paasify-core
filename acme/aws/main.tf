terraform {
  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.4.0"
    }
  }
}

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = "none@paasify.org"
}

resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = var.opsmanager_domain
  subject_alternative_names = var.additional_domains

  dns_challenge {
    provider = "route53"

    config = {
      AWS_HOSTED_ZONE_ID = var.dns_zone_id
    }
  }
}