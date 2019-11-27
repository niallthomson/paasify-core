#!/bin/bash

set -e

product_slug=$1
version=$2
glob=$3
iaas=$4
om_product=$5

install_tile $product_slug $version $glob $iaas $om_product

configure_tile $om_product