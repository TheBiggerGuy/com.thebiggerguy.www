#!/usr/bin/env bash

#set -o verbose
set -o errexit
set -o pipefail

FILE_TO_CHECK="${1}"

echo -n "Spelling check ${FILE_TO_CHECK} ... "
result=$(cat "${FILE_TO_CHECK}" | aspell --lang='en_GB' --home-dir="$(pwd)" --mode='html' --add-html-skip="githash" pipe | sed -E '/^[^&#]/d' | sed '/^$/d')
if echo "${result}" | grep -E '^[&#]' > /dev/null ; then
  echo "FAIL"
  echo '###############################################################################'
  echo "${result}" | sed -e 's/^& //g'
  echo '###############################################################################'
  exit 1
else
  echo "OK"
  exit 0
fi
