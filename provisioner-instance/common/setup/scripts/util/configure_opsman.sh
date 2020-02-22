#!/bin/bash

set -e

echo 'Configuring OpsMan...'
om configure-director -c /home/ubuntu/config/opsman-config.yml --ops-file /home/ubuntu/config/opsman-config-ops.yml

#om apply-changes -n p-bosh