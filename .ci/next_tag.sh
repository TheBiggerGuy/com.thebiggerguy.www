#!/usr/bin/env bash

#set -o verbose
set -o errexit
set -o pipefail

# Latest semver tag (default to v0.0.0 if none exist yet)
latest="$(gh api --paginate "repos/${GITHUB_REPOSITORY}/tags" --jq '.[].name' \
    | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -1)"
latest="${latest:-v0.0.0}"

# Increment the patch component
IFS=. read -r major minor patch <<< "${latest#v}"
new_tag="v${major}.${minor}.$((patch + 1))"

echo "Bumping ${latest} -> ${new_tag}"

# Expose the new tag to later workflow steps
# (the tag itself is created by `gh release create --target` in the next step)
echo "new_tag=${new_tag}" >> "${GITHUB_OUTPUT}"
