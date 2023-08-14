TEST_BREW_PREFIX="$(brew --prefix)"
load "${TEST_BREW_PREFIX}/lib/bats-support/load.bash"
load "${TEST_BREW_PREFIX}/lib/bats-assert/load.bash"

setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/test-redis
  mkdir -p $TESTDIR
  export PROJNAME=test-redis
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true
  cd "${TESTDIR}"
  # Create a project with a web container only
  ddev config --project-name=${PROJNAME} --omit-containers=db
  # Disable upload dirs warning
  ddev config --disable-upload-dirs-warning
  ddev start >/dev/null
  ddev stop > /dev/null
}

health_checks() {
  set +u # bats-assert has unset variables so turn off unset check
  # ddev restart is required because we have done `ddev get` on a new service
  run bash -c "ddev get $1"
  assert_success
  run bash -c "ddev start -y"
  assert_success

  # # Make sure `ddev redis` works
  run bash -c "DDEV_DEBUG=true ddev redis --version"
  assert_success
  assert_output "redis-cli 7.0.12"

  # # Keys should be an empty array
  run bash -c 'ddev redis "KEYS \*"'
  assert_success
  assert_output ""

  # # Set a key
  run bash -c "ddev redis DEBUG POPULATE 10000 TestKey"
  assert_success

  # # Get the number of keys
  run bash -c "ddev redis DBSIZE"
  assert_success
  assert_output "10000"
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
  ddev poweroff
}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  echo "# ddev get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  health_checks ${DIR}
}

@test "install from release" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev get oblakstudio/ddev-redis with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  health_checks "oblakstudio/ddev-redis-7"
}

