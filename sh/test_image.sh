#!/bin/bash -Eeu

readonly MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# don't create TMP_DIR off /tmp because on Docker Toolbox
# /tmp will not be available on the default VM
readonly TMP=$(cd ${MY_DIR} && mktemp -d XXXXXX)
readonly TMP_DIR=${MY_DIR}/${TMP}
remove_tmp_dir() { rm -rf "${TMP_DIR}" > /dev/null; }
trap remove_tmp_dir INT EXIT
source "${MY_DIR}/image_name.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - -
assert_equals()
{
  local -r expected="${1}"
  local -r actual="${2}"
  if [ "${expected}" != "${actual}" ]; then
    echo '--------------------------------------------'
    echo expected
    echo "${expected}"
    echo '--------------------------------------------'
    echo actual
    echo "${actual}"
    echo '--------------------------------------------'
    echo 'FAILED: assert_equals()'
    exit 42
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - -
image_namer()
{
  docker run \
    --rm \
    --volume "${PWD}:/data:ro" \
      "$(image_name)"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - -
check_base_language_repo()
{
  echo Checking python
  cd ${TMP_DIR}
  git clone https://github.com/cyber-dojo-languages/python.git
  cd python
  local -r expected=cyberdojofoundation/python
  local -r actual=$(image_namer)
  assert_equals "${expected}" "${actual}"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - -
check_test_framework_repo()
{
  echo Checking python-pytest
  cd ${TMP_DIR}
  git clone https://github.com/cyber-dojo-languages/python-pytest.git
  cd python-pytest
  local -r expected=cyberdojofoundation/python_pytest
  local -r actual=$(image_namer)
  assert_equals "${expected}" "${actual}"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - -
check_base_language_repo
check_test_framework_repo
