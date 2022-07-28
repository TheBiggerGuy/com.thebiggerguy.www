#!/usr/bin/env bash

set -o verbose
set -o errexit
set -o pipefail

python3 -m pip install --user --upgrade pip
python3 -m pip install --user --upgrade awscli
