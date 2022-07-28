#!/usr/bin/env bash

set -o verbose
set -o errexit
set -o pipefail

# Install apt
.ci/install_base.sh
# Install Hugo
.ci/install_hugo.sh "${HOME}/.local"
# Install AWS CLI
.ci/install_awscli.sh
# Export new tools to PATH
export PATH="${HOME}/.local/bin:${PATH}"
export LD_LIBRARY_PATH="${HOME}/.local/lib:${LD_LIBRARY_PATH}"
# Log the versions and paths
hugo version
aws --version

# Build the site
hugo -s site
# Spell Check
# Requires AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
aws s3 sync 'site/public' 's3://com.thebiggerguy.www' --region='eu-west-1' --acl='private' --delete
aws cloudfront create-invalidation --distribution-id "${AWS_CLOUDFRONT_DISTRIBUTION_ID}" --paths '/*'
