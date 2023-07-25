#!/bin/bash
set -e -o pipefail

workspace="$1"
if [ "$1" == '' ]; then
  echo 'Workspace root expected'
  exit 1
fi

conf="$HOME/.vimrc"

if [ -f "$conf" ]; then
  echo "$conf already exists. Skipping."
else
  echo "source $workspace/vimrc" > "$conf"
  echo "$conf created."
fi
