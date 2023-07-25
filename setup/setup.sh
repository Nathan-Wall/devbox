#!/bin/bash
set -e -o pipefail

workspace="$PWD"

echo -n "Enter devbox workspace root [$workspace]: "
read workspace_input

if [ "$workspace_input" != '' ]; then
  workspace="$workspace_input"
fi

if [ ! -d "$workspace" ]; then
  echo "Workspace $workspace not found." >&2
  exit 1
fi

devbox_setup="$workspace/setup"
"$devbox_setup/setup_tmux.sh" "$workspace"
"$devbox_setup/setup_vim.sh" "$workspace"
echo ''
echo '.bashrc must be set up manully by adding the following lines:'
echo "if [ -f $workspace/bash_files/index ]; then"
echo "  . $workspace/bash_files/index"
echo 'fi'
