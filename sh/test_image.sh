#!/bin/bash
set -e

readonly TMP_DIR=$(mktemp -d)

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
