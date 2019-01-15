#!/usr/bin/env bash

#set -o verbose
set -o errexit
set -o pipefail

FILE_TO_CHECK="${1}"

echo "Spelling check ${FILE_TO_CHECK} ..."
aspell --lang='en_GB' --home-dir="$(pwd)" --mode='html' --add-html-skip="githash" pipe < "${FILE_TO_CHECK}" | grep '[^*]' | grep -v '^@(#) ' | tee >(grep -v '.*')
echo "... done"
