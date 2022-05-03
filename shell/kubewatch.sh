#! /bin/bash

set -e
set -o pipefail

# Constants
max_sleep_time=10
increase_every_x_attempts=10

# Temp file
tmpfile=`mktemp`
cleanup() {
  exit_code=$?
  rm -f $tmpfile
  exit $exit_code
}
trap cleanup EXIT

# Main loop
i=0
while true; do
  # Run kube command
  set +e
  kubectl >$tmpfile 2>&1 $@
  ret=$?
  set -e

  # Display result
  clear
  echo "$ kw $@"
  cat $tmpfile
  if [ $ret -ne 0 ]; then
    echo "Returned exit code $ret"
  fi

  # Sleep
  theorical_sleep_time=$((i / increase_every_x_attempts + 1))
  sleep_time=$((theorical_sleep_time < max_sleep_time ? theorical_sleep_time : max_sleep_time))
  sleep $sleep_time

  i=$((i + 1))
done
