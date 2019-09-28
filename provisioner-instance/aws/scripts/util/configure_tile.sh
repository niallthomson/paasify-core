#!/bin/bash

set -e

product_name=$1

if [ -z "$product_name" ]; then
  echo "Error setting up tile - product name not specified"
  exit 1
fi

echo "Configuring tile $product_name"

config_path="~/config/$product_name-config.yml"
ops_path="~/config/$product_name-config-ops.yml"

if [ -f "$ops_path" ]; then
  om configure-product -c "$config_path" -o "$ops_path"
else
  om configure-product -c "$config_path"
fi