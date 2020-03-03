# paasify-core

![](https://github.com/niallthomson/paasify-core/workflows/CI/badge.svg)

`paasify` is a collection of projects that are intended to provide a simple and consistent way to install a set of products from Pivotal (now VMware) that rely on Pivotal OpsManager. This is presented as a set of Terraform modules that can be used to complete cookie-cutter installations end-to-end with `terraform apply`. The use-cases that this is intended for are to provision environments for sandboxes, proof-of-concepts and demos. This is absolutely not intended to provide production-grade installs.

This repository contains Terraform modules that constitute the core of the various downstream `paasify` projects (PAS and PKS). They provide common functions such as building a paving the IaaS infrastructure, a provisioner jump box, generating director config and creating ACME certificates.

## Modules

The following table providers a brief description of each module. For more thorough documentation please see each module.

| Module | Purpose |
|-----------------------|-------------------------------------------------------------------------------------------------------------------------------|
| pave | This module aggregates all of the other modules to provide "everything", from IaaS infrastructure up to a working OpsManager |
| acme | Generates HTTPS certificates for the necessary domains using LetsEncrypt |
| apply-changes | Runs `apply-changes` on an OpsManager via the provisioner jumpbox |
| build-director-config | Generates the YAML used by `configure-director` |
| build-network-config | Generates the YAML used by the network portion of `configure-director` |
| configure-director | Runs `configure-director` on an OpsManager via the provisioner jumpbox |
| infra | Builds the infrastructure necessary for each cloud provider |
| opsmanager-tile | Installs and configures a tile in an existing OpsManager via the provisioner jumpbox |
| provisioner-instance | Builds a 'provisioner instance' which is used as a jumpbox to execute operations against OpsManager |
| run-script | Runs an arbitrary bash script on the provisioner instance |

## General Notes

Here are some general notes on using the modules

### When would I use these modules by themselves?

In general its expected that users will be consuming the downstream modules that actually produce working systems (paasify-pas, paasify-pks etc.) rather than using these modules directly. However, there are two main use-cases for these modules:

- Adding customizations to the downstream projects, such as adding more tiles
- Building out a new system that is not PAS, PKS etc.

### What are these blocker things?

The amount of work being done when combining these modules is a bit complex, and Terraform still struggles a little bit with cross-module dependency management. The `blocker` variables and arguments are used to control some of the tricker dependencies between components, especially related to tearing down foundations. Generally the `blocker` variables are optional, but you can check out how the `pave` module passes around blockers between multiple modules to orchestrate the overall flow.

### Important things are exposed over the Internet

This is intentional, as these foundations are expected to be used for transient environments rather than anything important. There are many options and configurations that could be introduced to make the architecture more "production-like", but that would go against the spirit of the general nature of what these modules are intended for.

### More?
