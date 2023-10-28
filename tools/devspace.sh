#!/bin/bash
set -e -o pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
devbox_root="$(cd -- "$script_dir/.." && pwd)"

if [ "$1" == 'devbox' ]; then
  echo "$devbox_root"
  exit 0
fi

# Look for .devspace or .forjespace
until [ -e .devspace ] || [ -e .forjespace ] || [ $(pwd) == '/' ]; do
  cd ..
done
if [ -e .devspace ] || [ -e .forjespace ]; then
  space="$(pwd)"
  export FORJESPACE="$space"
  echo "$space"
elif [ "$1" != '--nofail' ]; then
  echo 'No dev workspace found in parent directories.' >&2
  exit 1
fi

