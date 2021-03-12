#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

association=#${{ github.event.comment.author_association }}

if [[ $association =~ ^(OWNER|MEMBER|COLLABORATOR)$ ]]; then
  body=#${{ github.event.comment.body }}
  echo $body
  if [[ $body == "@kloonbot run ci"* ]]; then
    echo "woot"
  fi
fi
