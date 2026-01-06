# Creating the Jayson Branch and Setting it as Default

## Overview

This PR prepares the repository for creating a new "jayson" branch and setting it as the default branch. The jayson branch has been created locally and is ready to be pushed to the remote repository.

## Current Status

✅ **jayson** branch created locally at commit `d6df2670`  
✅ Documentation and helper script provided  
⏳ Awaiting push to remote (requires repository admin to complete)  
⏳ Default branch change pending (requires repository admin access)

## Quick Start - Complete the Setup

Run the provided script to push the jayson branch and get instructions:

```bash
./create_jayson_branch.sh
```

## Manual Steps to Complete

### Step 1: Push the Jayson Branch to Remote

```bash
# Ensure you're in the repository directory
cd /path/to/Telegram

# Checkout the jayson branch (already created)
git checkout jayson

# Push to remote
git push -u origin jayson
```

### Step 2: Set Jayson as Default Branch

#### Option A: GitHub Web Interface (Recommended)

1. Go to **https://github.com/JaysonKhan/Telegram/settings/branches**
2. Under "Default branch", click the **switch branches** icon (⇄) or pencil icon
3. Select **jayson** from the dropdown menu
4. Click **Update** or **I understand, update the default branch**
5. Confirm the change

#### Option B: Using GitHub CLI

```bash
# Set as default branch using GitHub CLI (requires gh auth login)
gh repo edit JaysonKhan/Telegram --default-branch jayson
```

#### Option C: Using GitHub API

```bash
# Using curl with a personal access token
curl -X PATCH \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token YOUR_GITHUB_TOKEN" \
  https://api.github.com/repos/JaysonKhan/Telegram \
  -d '{"default_branch":"jayson"}'
```

## Branch Information

- **Branch Name**: jayson
- **Based On**: commit `d6df2670` (current state of repository)
- **Contains**: All current code plus this documentation

## After Changing Default Branch

Once the default branch is changed to jayson:

1. **For existing contributors**: Update your local repository
   ```bash
   git fetch origin
   git checkout jayson
   git branch --set-upstream-to=origin/jayson
   ```

2. **New clones** will automatically use the jayson branch

3. **Update CI/CD**: Check if any CI/CD pipelines or workflows reference the old default branch and update them

4. **Pull Requests**: Existing PRs will keep their base branch, but new PRs will target jayson by default

## Important Notes

- ⚠️ Changing the default branch requires **repository admin permissions**
- ⚠️ The jayson branch is currently only available locally until pushed to remote
- ⚠️ After changing the default branch, review and update any branch protection rules as needed
- ℹ️ The old default branch (master) will still exist and can be deleted if no longer needed

## Troubleshooting

### If the jayson branch doesn't exist locally

```bash
git fetch origin
git checkout -b jayson origin/jayson
```

### If you get authentication errors when pushing

Make sure you have:
- Valid GitHub credentials configured
- Push access to the repository
- Two-factor authentication token if required

## Questions?

If you encounter any issues or have questions about this process, please refer to:
- GitHub Documentation: https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-branches-in-your-repository/changing-the-default-branch
