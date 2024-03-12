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

# Get git hash
if [[ -z "${GITHUB_SHA}" ]]; then
    GIT_HASH="${GITHUB_SHA}"
else
    GIT_HASH="$(git describe --always --dirty)"
fi
echo "GitHash=${GIT_HASH}"

# Requires AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY or OIDC
aws cloudformation deploy \
    --template-file cloudformation.yaml \
    --stack-name com-thebiggerguy-www \
    --region='eu-west-1' \
    --parameter-overrides "GitHash=${GIT_HASH}"
aws s3 sync \
    'site/public' 's3://com.thebiggerguy.www' \
    --region='eu-west-1' \
    --acl='private' \
    --delete
aws cloudfront create-invalidation \
    --distribution-id "${AWS_CLOUDFRONT_DISTRIBUTION_ID}" \
    --paths '/*'
