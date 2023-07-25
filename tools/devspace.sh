#!/bin/bash
set -e -o pipefail

if [ "$1" == 'devbox' ]; then
  echo '/home/nathan/devbox'
  exit 0
fi

# Look for .devspace
until [ -e .devspace ] || [ $(pwd) == '/' ]; do
  cd ..
done
if [ -e .devspace ]; then
  echo "$(pwd)"
elif [ "$1" != '--nofail' ]; then
  echo 'No dev workspace found in parent directories.' >&2
  exit 1
fi
