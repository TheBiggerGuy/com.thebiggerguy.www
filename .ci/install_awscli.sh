#!/usr/bin/env bash

set -o verbose
set -o errexit
set -o pipefail

python3 -m pip install --user --upgrade pip
python3 -m pip install --user --upgrade git+https://github.com/aws/aws-cli.git@v2
