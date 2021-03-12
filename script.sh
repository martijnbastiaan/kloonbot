#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

if [[ $KBOT_AUTHOR_ASSOC =~ ^(OWNER|MEMBER|COLLABORATOR)$ ]]; then
  echo $KBOT_COMMENT
  if [[ $KBOT_COMMENT == "@kloonbot run ci"* ]]; then
    echo "woot"
  fi
fi
