#!/usr/bin/env bash

#set -o verbose
set -o errexit
set -o pipefail

# For hunspell
sudo apt install -y \
    hunspell \
    hunspell-en-gb \
    hunspell-en-us

# For AWS CLI/CF Lint
sudo apt install -y \
    python3-pip

python3 -m pip install --user --upgrade pip
python3 -m pip install --user --upgrade setuptools wheel pipx
