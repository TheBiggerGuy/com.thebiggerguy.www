#!/usr/bin/env bash

set -o verbose
set -o errexit
set -o pipefail

pip install --user --upgrade pip
pip install --user --upgrade awscli
