#!/bin/bash

source ~/.bash_profile
source ~/.load_secrets

echo "Wrapping $1"

{
  eval "$@"
} || {
    echo "Caught error in $1"
    # This is needed to ensure output
    sleep 1
    exit 1
}

echo "Finished $1"