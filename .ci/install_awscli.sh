#!/usr/bin/env bash

#set -o verbose
set -o errexit
set -o pipefail

source "${BASH_SOURCE%/*}/versions.sh"

echo "AWS_CLI_VERSION=${AWS_CLI_VERSION}"
echo "AWS_CLI_HASH=${AWS_CLI_HASH}"

CACHE_DIR="${1}/cache"
CACHE_ZIP="${CACHE_DIR}/awscli-exe-linux-x86_64.zip"

echo "CACHE_DIR=${CACHE_DIR}"
echo "CACHE_ZIP=${CACHE_ZIP}"

mkdir -p "${CACHE_DIR}"
curl -L --output "${CACHE_ZIP}" --time-cond "${CACHE_ZIP}" \
    "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip"
sha256sum "${CACHE_ZIP}"
echo "${AWS_CLI_HASH}  ${CACHE_ZIP}" | sha256sum -c

unzip -q -o "${CACHE_ZIP}" -d /tmp/awscli-install
/tmp/awscli-install/aws/install \
    --install-dir "${1}/aws-cli" \
    --bin-dir "${1}/bin" \
    --update
rm -rf /tmp/awscli-install
