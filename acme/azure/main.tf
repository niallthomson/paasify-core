provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"

  version = "~> 1.4.0"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = "none@paasify.org"
}

resource "null_resource" "acme_blocker" {
  provisioner "local-exec" {
    command = "echo ${var.blocker}"
  }
}

resource "acme_certificate" "certificate" {
  depends_on = [null_resource.acme_blocker]

  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = var.opsmanager_domain
  subject_alternative_names = var.additional_domains

  dns_challenge {
    provider = "azure"

    config = {
      AZURE_CLIENT_ID       = var.client_id
      AZURE_CLIENT_SECRET   = var.client_secret
      AZURE_SUBSCRIPTION_ID = var.subscription_id
      AZURE_TENANT_ID       = var.tenant_id
      AZURE_RESOURCE_GROUP  = var.resource_group_name
    }
  }
}