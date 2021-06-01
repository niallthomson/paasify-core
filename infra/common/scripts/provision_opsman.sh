#!/bin/bash

set -e

# Update HTTPS certificate
echo 'Installing HTTPS certificate...'

if [ -f /tmp/tempest.key ]; then
  sudo cp /tmp/tempest.* /var/tempest/cert

  sudo service nginx restart
fi

echo "Restarting nginx..."

# TODO: Replace with reliable wait, not even sure what could fail. DNS? OpsMan restart?
sleep 60