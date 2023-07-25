#!/bin/bash
set -e -o pipefail

workspace="$1"
if [ "$1" == '' ]; then
  echo 'Workspace root expected'
  exit 1
fi

tmux_conf="$HOME/.tmux.conf"

if [ -f "$tmux_conf" ]; then
  echo "$tmux_conf already exists. Skipping."
else
  echo "source-file $workspace/tmux.conf" > "$tmux_conf"
  echo "$tmux_conf created."
fi
