#!/usr/bin/env bash

#set -o verbose
set -o errexit
set -o pipefail

echo "HUGO_VERSION=${HUGO_VERSION}"
echo "HUGO_HASH=${HUGO_HASH}"

CACHE_DIR="${1}/cache"
CACHE_TAR="${CACHE_DIR}/hugo_extended_Linux-64bit.tar.gz"

echo "CACHE_DIR=${CACHE_DIR}"
echo "CACHE_TAR=${CACHE_TAR}"

mkdir -p "${CACHE_DIR}"
curl -L --output "${CACHE_TAR}" --time-cond "${CACHE_TAR}" \
	"https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz"
sha256sum "${CACHE_TAR}"
echo "${HUGO_HASH}  ${CACHE_TAR}" | sha256sum -c
tar -xvf "${CACHE_TAR}" 'hugo'

mkdir -p "${1}/bin"
mv 'hugo' "${1}/bin/hugo"
chmod +x "${1}/bin/hugo"
