#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

association=$1
body=$2

if [[ $association =~ ^(OWNER|MEMBER|COLLABORATOR)$ ]]; then
  echo $body
  if [[ $body == "@kloonbot run ci"* ]]; then
    echo "woot"
  fi
fi

echo "${{ github.event.comment.author_association }}"
