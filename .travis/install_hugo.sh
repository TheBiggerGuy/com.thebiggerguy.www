#!/usr/bin/env bash

set -o verbose
set -o errexit
set -o pipefail

curl -L --output 'hugo_extended_Linux-64bit.tar.gz' "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz"
sha256sum 'hugo_extended_Linux-64bit.tar.gz'
echo "${HUGO_HASH}  hugo_extended_Linux-64bit.tar.gz" | sha256sum -c
tar -xvf 'hugo_extended_Linux-64bit.tar.gz' 'hugo'
rm 'hugo_extended_Linux-64bit.tar.gz'

mkdir -p "${HOME}/.local/bin"
mv 'hugo' "${HOME}/.local/bin/hugo"
chmod +x "${HOME}/.local/bin/hugo"
