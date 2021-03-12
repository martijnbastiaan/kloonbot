#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

HEADERS="Accept: application/vnd.github.v3+json"

if [[ $KBOT_AUTHOR_ASSOC =~ ^(OWNER|MEMBER|COLLABORATOR)$ ]]; then
  echo $KBOT_COMMENT
  if [[ $KBOT_COMMENT == "@kloonbot run ci"* ]]; then
    pull_request_json=$(curl -H "${HEADERS}" "${KBOT_PULL_REQUEST_URL}")
    is_fork=$(echo "$pull_request_json" | jq ".head.repo.fork")
    if [[ ${is_fork} == "true" ]]; then
      echo "yeah!"
    fi
    echo "woot"
  fi
fi
