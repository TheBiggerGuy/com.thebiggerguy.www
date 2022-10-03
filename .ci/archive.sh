#!/usr/bin/env bash

set -o verbose
set -o errexit
set -o pipefail

# Install apt
.ci/install_base.sh
# Install Hugo
.ci/install_hugo.sh "${HOME}/.local"
# Log the versions and paths
hugo version

# Builds the site
hugo -s site
tar -czvf public.tar.gz site/public