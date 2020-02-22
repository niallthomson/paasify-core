#!/bin/bash

set -e

om bosh-env > ~/.bashrc.d/bosh.bashrc

source ~/.bashrc.d/bosh.bashrc

# Test authentication
bosh deployments