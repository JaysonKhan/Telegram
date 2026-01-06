#!/bin/bash

# Script to create and push the jayson branch
# This script should be run by a user with push access to the repository

set -e

echo "Creating jayson branch..."

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not in a git repository"
    exit 1
fi

# Check if jayson branch already exists locally
if git show-ref --verify --quiet refs/heads/jayson; then
    echo "Branch 'jayson' already exists locally"
    git checkout jayson
else
    echo "Creating new branch 'jayson'"
    git checkout -b jayson
fi

# Push to remote
echo "Pushing jayson branch to remote..."
if git push -u origin jayson; then
    echo "✓ Successfully created and pushed 'jayson' branch"
    echo ""
    echo "Next steps:"
    echo "1. Go to https://github.com/JaysonKhan/Telegram/settings/branches"
    echo "2. Change the default branch to 'jayson'"
    echo "3. Click 'Update' to confirm"
else
    echo "✗ Failed to push branch. Check your permissions and authentication."
    exit 1
fi
