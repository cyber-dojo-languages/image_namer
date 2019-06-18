#!/bin/bash
set -e

readonly MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"
# don't create TMP_DIR off /tmp because on Docker Toolbox
# /tmp will not be available on the default VM
readonly TMP=$(cd ${MY_DIR} && mktemp -d XXXXXX)
readonly TMP_DIR=${MY_DIR}/${TMP}

remove_tmp_dir()
{
  rm -rf "${TMP_DIR}" > /dev/null;
}

trap remove_tmp_dir INT EXIT

assert_equals()
{
  local -r expected="${1}"
  local -r actual="${2}"
  if [ "${expected}" != "${actual}" ]; then
    echo 'FAILED'
    echo "expected: ${expected}"
    echo "  actual: ${actual}"
    exit 3
  fi
}

image_namer()
{
  docker run \
    --rm \
    --volume "${PWD}:/data:ro" \
      cyberdojofoundation/image_namer
}

cd ${TMP_DIR}
git clone https://github.com/cyber-dojo-languages/python.git
cd python
EXPECTED=cyberdojofoundation/python
ACTUAL=$(image_namer)
assert_equals "${EXPECTED}" "${ACTUAL}"

cd ${TMP_DIR}
git clone https://github.com/cyber-dojo-languages/python-pytest.git
cd python-pytest
EXPECTED=cyberdojofoundation/python_pytest
ACTUAL=$(image_namer)
assert_equals "${EXPECTED}" "${ACTUAL}"
