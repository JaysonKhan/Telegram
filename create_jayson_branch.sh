#!/bin/bash

# Script to create and push the jayson branch and set it as default
# This script should be run by a user with push access to the repository

set -e

REPO_OWNER="JaysonKhan"
REPO_NAME="Telegram"
BRANCH_NAME="jayson"
# Expected commit can be overridden by .jayson-branch-ref file if it exists
if [ -f ".jayson-branch-ref" ]; then
    EXPECTED_COMMIT=$(cat .jayson-branch-ref | tr -d '\n' | tr -d ' ')
else
    EXPECTED_COMMIT="a8ec3a867d2385249973fca9e09cfde96489810e"
fi

echo "=================================="
echo "Jayson Branch Setup Script"
echo "=================================="
echo ""

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

echo "✓ In git repository"

# Check if origin remote exists
if ! git remote | grep -q "^origin$"; then
    echo "❌ Error: 'origin' remote not found"
    echo "Available remotes:"
    git remote -v
    exit 1
fi

echo "✓ Remote 'origin' exists"

# Validate expected commit exists
if ! git cat-file -e "$EXPECTED_COMMIT" 2>/dev/null; then
    echo "❌ Error: Expected commit $EXPECTED_COMMIT not found in repository"
    echo "This might mean the repository state is different than expected"
    exit 1
fi

echo "✓ Expected commit exists: $EXPECTED_COMMIT"

# Check if jayson branch already exists locally
if git show-ref --verify --quiet refs/heads/jayson; then
    echo "✓ Branch 'jayson' already exists locally"
    CURRENT_COMMIT=$(git rev-parse jayson)
    
    if [ "$CURRENT_COMMIT" = "$EXPECTED_COMMIT" ]; then
        echo "✓ Branch is at expected commit: $EXPECTED_COMMIT"
    else
        echo "⚠️  Warning: Branch commit ($CURRENT_COMMIT) differs from expected ($EXPECTED_COMMIT)"
        read -p "Continue anyway? (y/n) [n]: " -n 1 -r
        echo
        # Default to 'n' if no input or non-y/Y input
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Aborted by user"
            exit 1
        fi
    fi
    
    git checkout jayson
else
    echo "⚠️  Branch 'jayson' does not exist locally"
    echo "Creating new branch 'jayson' from commit $EXPECTED_COMMIT"
    
    if git checkout -b jayson $EXPECTED_COMMIT; then
        echo "✓ Created branch 'jayson'"
    else
        echo "❌ Failed to create branch"
        exit 1
    fi
fi

echo ""
echo "Pushing jayson branch to remote..."

if git push -u origin jayson; then
    echo ""
    echo "=========================================="
    echo "✓ Successfully pushed 'jayson' branch!"
    echo "=========================================="
    echo ""
    echo "Next steps to set as default branch:"
    echo ""
    echo "Option 1 - GitHub Web Interface (Recommended):"
    echo "  1. Go to: https://github.com/$REPO_OWNER/$REPO_NAME/settings/branches"
    echo "  2. Click the switch icon next to 'Default branch'"
    echo "  3. Select 'jayson' from the dropdown"
    echo "  4. Click 'Update' to confirm"
    echo ""
    echo "Option 2 - GitHub CLI (if authenticated):"
    echo "  gh repo edit $REPO_OWNER/$REPO_NAME --default-branch jayson"
    echo ""
    echo "Option 3 - GitHub API (requires personal access token):"
    echo "  curl -X PATCH \\"
    echo "    -H 'Accept: application/vnd.github.v3+json' \\"
    echo "    -H 'Authorization: token YOUR_TOKEN' \\"
    echo "    https://api.github.com/repos/$REPO_OWNER/$REPO_NAME \\"
    echo "    -d '{\"default_branch\":\"jayson\"}'"
    echo ""
    echo "=========================================="
else
    echo ""
    echo "❌ Failed to push branch"
    echo ""
    echo "Possible causes:"
    echo "  - No push access to the repository"
    echo "  - Authentication failure"
    echo "  - Network issues"
    echo ""
    echo "Please ensure you have:"
    echo "  1. Valid GitHub credentials configured"
    echo "  2. Push access to $REPO_OWNER/$REPO_NAME"
    echo "  3. Two-factor authentication token if required"
    echo ""
    exit 1
fi
