#!/usr/bin/env bash

#set -o verbose
set -o errexit
set -o pipefail

FILE_TO_CHECK="${1}"

export DICPATH="$(pwd)/libreoffice_dictionaries/en"

echo -n "Spelling check ${FILE_TO_CHECK} ... "
result=$(hunspell -d='en_GB' -p "$(pwd)/.hunspell_default" -H -i 'UTF-8' -a "${FILE_TO_CHECK}" | sed -E '/^[^&#]/d' | sed '/^$/d')
if echo "${result}" | grep -E '^[&#] ' > /dev/null ; then
  echo "FAIL"
  echo '###############################################################################'
  echo "${result}" | sed -e 's/^& //g'
  echo '###############################################################################'
  exit 1
else
  echo "OK"
  exit 0
fi
