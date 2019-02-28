#!/usr/bin/env bash

set -o verbose
set -o errexit
set -o pipefail

cd hunspell

if which hunspell > /dev/null ; then
  echo 'Hunspell already found on the system'

  git fetch --tags
  GIT_VERSION="$(git describe --tags)"
  CACHED_VERSION="v$(hunspell --version | head --lines=1 | sed -E 's/.*Hunspell ([0-9]+.[0-9]+.[0-9]+).*/\1/g')"

  echo "GIT_VERSION=${GIT_VERSION} and CACHED_VERSION=${CACHED_VERSION}"
  if [ "${GIT_VERSION}" = "${CACHED_VERSION}" ]; then
    echo "Cached/Installed version equal to git version"
    exit 0
  else
    echo "Cached/Installed version NOT equal to git version"
  fi
else
  echo 'No Hunspell found on the PATH'
fi

autoreconf -vfi
./configure --prefix="${HOME}/.local"
make
make install
