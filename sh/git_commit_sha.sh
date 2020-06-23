#!/bin/bash -Eeu

git_commit_sha()
{
  echo "$(cd "${MY_DIR}/.." && git rev-parse HEAD)"
}
