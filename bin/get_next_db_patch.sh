#!/bin/bash
set -e -o pipefail
workspace=$(get_stacksource_workspace 2> /dev/null)

last=$(
    find "$workspace/bloomlake/kennedy/BUILD/patches/" \
            -maxdepth 1 \
        | sort -t_ -nk2,2 \
        | tail -n1)
last_basename=$(basename $last)
number="${last_basename%.*}"

next_number="$((10#$number + 1))"

if [ $next_number -lt 1000 ]; then
  echo "0$next_number"
elif [ $next_number -gt 999 ]; then
  echo "$next_number"
else
  echo "Invalid patch number $next_number" >2
  exit 1
fi
