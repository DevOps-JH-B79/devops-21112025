#!/bin/bash

# Fetch tags from remote first
git fetch --tags

# Get latest tag (if no tag exists, default to v0.0)
latest_tag=$(git describe --tags `git rev-list --tags --max-count=1` 2>/dev/null)

if [ -z "$latest_tag" ]; then
    latest_tag="v0.0"
fi

echo "Latest tag: $latest_tag"

# Extract major and minor versions
major=$(echo $latest_tag | cut -d '.' -f1 | sed 's/v//')
minor=$(echo $latest_tag | cut -d '.' -f2)

# Increment minor version
new_minor=$((minor + 1))
new_tag="v${major}.${new_minor}"

echo "New tag will be: $new_tag"

# Create and push tag
git tag -a $new_tag -m "Auto-created tag $new_tag"
git push origin $new_tag

echo "Tag $new_tag created and pushed successfully!"
 