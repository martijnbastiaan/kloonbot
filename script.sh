#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

HEADERS="Accept: application/vnd.github.v3+json"

kloon_fork_branch_to_local_branch() {
  local pull_request_json="$1"

  git remote add fork $remote
  git fetch fork
  git checkout -b fork/$forkbranchname
  git reset $commithash --hard
  git push -f

}

parse_comment(){
  local at=$(echo "${KBOT_COMMENT}" | awk '{print $1}')
  local cmd=$(echo "${KBOT_COMMENT}" | awk '{print $2}')
  local commit=$(echo "${KBOT_COMMENT}" | awk '{print $3}')

  echo ${at}
  echo ${cmd}
  echo ${commit}

  if [[ ${at} == "@kloonbot" && ${cmd} == "run_ci" ]]; then
    echo "${commit}"
  else
    echo "${KBOT_COMMENT}"
    exit 1;
  fi
}

if [[ $KBOT_AUTHOR_ASSOC =~ ^(OWNER|MEMBER|COLLABORATOR)$ ]]; then
  commit=$(parse_comment)

  pull_request_json=$(curl -H "${HEADERS}" "${KBOT_PULL_REQUEST_URL}")
  is_fork=$(echo "$pull_request_json" | jq ".head.repo.fork")

  if [[ ${is_fork} == "true" ]]; then
    # At this point we've established that:
    #
    #  1. This pull request is coming from a forked repo
    #  2. A comment was made by someone trusted
    #  3. The comment indicated CI should be run on local runners
    kloon_fork_branch_to_local_branch "${pull_request_json}" "${commit}"
  fi
fi
