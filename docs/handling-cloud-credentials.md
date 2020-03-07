# Handling Cloud Credentials

Paasify assumes that the context in which you're executing contains the appropriate credentials for whichever cloud you are attempting to deploy to, with Azure being the exception. None of the other cloud modules expose credential parameters. See below for examples for how you can make sure you are passing the appropriate credentials:

## AWS

Your options for AWS are:
- Log in with the `aws` CLI
- Set `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` and `AWS_DEFAULT_REGION` environment variables in the shell you're running in

## GCP

Your options for GCP are:
- Log in with the `gcloud` cli
- Set `GOOGLE_CREDENTIALS`, `GOOGLE_PROJECT` and `GOOGLE_REGION` environment variables in the shell you're running in

## Azure

The combination of Azure and BOSH has several constraints which make it awkward to inherit credentials as AWS and GCP do. As a result you must explicitly pass in variables exposed by the module to authenticate (`subscription_id`, `tenant_id`, `client_id` and `client_secret`).