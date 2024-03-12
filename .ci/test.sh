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
# Export dictionaries and lang
export DICPATH='/usr/share/hunspell'
export DICTIONARY='en_GB'
export WORDLIST="$(pwd)/.hunspell_default"
# Log the versions and paths
hugo version
hunspell --version
hunspell -D -a /dev/null || true

# Test the site builds
hugo -s site

# Spell Check
git log --format="%H" >> .hunspell_default
find site/public -type f -name "*.html" -print0 | xargs -0 -I{} .ci/spell_check.sh "{}"

# Lint CF template
.ci/lint_cf.sh
