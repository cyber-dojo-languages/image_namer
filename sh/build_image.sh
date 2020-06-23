#!/bin/bash -Eeu

readonly MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"
source "${MY_DIR}/image_name.sh"
source "${MY_DIR}/git_commit_sha.sh"

docker build \
  --tag "$(image_name)" \
  "${MY_DIR}/.." \
  --build-arg GIT_COMMIT_SHA="$(git_commit_sha)"
