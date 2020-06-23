#!/bin/bash -Eeu

readonly MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${MY_DIR}/image_name.sh"
source "${MY_DIR}/git_commit_sha.sh"

# - - - - - - - - - - - - - - - - - - - - - - - -
on_ci_publish_tagged_images()
{
  if ! on_ci; then
    echo 'not on CI so not publishing image'
    return
  fi
  echo 'on CI so publishing tagged image'
  docker tag $(image_name) $(image_name):$(git_commit_tag)
  echo "Tagged to $(image_name):$(git_commit_tag)"
  # DOCKER_USERNAME, DOCKER_PASSWORD are in ci context
  echo "${DOCKER_PASSWORD}" | docker login --username "${DOCKER_USERNAME}" --password-stdin
  docker push "$(image_name)"
  echo "Pushed $(image_name) to dockerhub"
  docker push "$(image_name):$(git_commit_tag)"
  echo "Pushed $(image_name):$(git_commit_tag) to dockerhub"
  docker logout
}

# - - - - - - - - - - - - - - - - - - - - - - -
git_commit_tag()
{
  local -r sha="$(git_commit_sha)"
  echo "${sha:0:7}"
}

# - - - - - - - - - - - - - - - - - - - - - - - -
on_ci()
{
  set +u
  [ -n "${CIRCLECI}" ]
  local -r result=$?
  set -u
  [ "${result}" == '0' ]
}

# - - - - - - - - - - - - - - - - - - - - - - - -
on_ci_publish_tagged_images
