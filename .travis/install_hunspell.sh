#!/usr/bin/env bash

set -o verbose
set -o errexit
set -o pipefail

cd hunspell

autoreconf -vfi
./configure --prefix="${HOME}/.local"
make
make install
