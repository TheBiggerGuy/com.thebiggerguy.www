#!/usr/bin/env bash

#set -o verbose
set -o errexit
set -o pipefail

FILE_TO_CHECK="${1}"

echo "Lint checking CloudFormation template..."

if ! [ -x "$(command -v cfn-lint)" ]; then
    pipx install cfn-lint
fi

cfn-lint --template cloudformation.yaml
