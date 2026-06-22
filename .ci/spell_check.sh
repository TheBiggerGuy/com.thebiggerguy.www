#!/usr/bin/env bash

#set -o verbose
set -o errexit
set -o pipefail

source .ci/versions.sh

# Log the versions
node --version
npm --version

npm exec --yes \
    --package="cspell@${CSPELL_VERSION}" \
    --package="@cspell/dict-en-gb@${CSPELL_DICT_EN_GB_VERSION}" \
    -- cspell --no-progress "site/public/**/*.html"
