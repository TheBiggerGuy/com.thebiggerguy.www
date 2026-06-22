#!/usr/bin/env bash

set -o verbose
set -o errexit
set -o pipefail

# Install apt
.ci/install_base.sh
# Install Hugo
.ci/install_hugo.sh "${HOME}/.local"
# Export new tools to PATH
export PATH="${HOME}/.local/bin:${PATH}"
export LD_LIBRARY_PATH="${HOME}/.local/lib:${LD_LIBRARY_PATH}"
# Log the versions and paths
hugo version

# Test the site builds
hugo -s site

# Spell Check
.ci/spell_check.sh

# Lint CF template
.ci/lint_cf.sh
