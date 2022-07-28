#!/usr/bin/env bash

#set -o verbose
set -o errexit
set -o pipefail

# For hunspell
sudo apt install -y \
    hunspell \
    hunspell-en-gb \
    hunspell-en-us

# For AWS CLI
sudo apt install -y \
    python3-pip
