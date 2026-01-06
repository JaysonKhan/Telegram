# Creating the Jayson Branch

## Branch Creation Instructions

This document provides instructions for creating the "jayson" branch and setting it as the default branch for this repository.

## Steps to Create and Set Default Branch

### 1. Create the Jayson Branch

The "jayson" branch needs to be created from the current state of the repository. This can be done using:

```bash
git checkout -b jayson
git push -u origin jayson
```

### 2. Set as Default Branch (GitHub Web Interface)

To change the default branch on GitHub:

1. Go to the repository on GitHub: https://github.com/JaysonKhan/Telegram
2. Click on **Settings** (requires admin access)
3. Click on **Branches** in the left sidebar
4. Under "Default branch", click the switch icon or pencil icon
5. Select **jayson** from the dropdown
6. Click **Update** or **I understand, update the default branch**

### 3. Alternative: Using GitHub CLI

If you have GitHub CLI installed with proper authentication:

```bash
# Create and push the branch
git checkout -b jayson
git push -u origin jayson

# Set as default branch using GitHub CLI
gh repo edit --default-branch jayson
```

### 4. Alternative: Using GitHub API

If you have a GitHub personal access token with repo permissions:

```bash
curl -X PATCH \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token YOUR_TOKEN" \
  https://api.github.com/repos/JaysonKhan/Telegram \
  -d '{"default_branch":"jayson"}'
```

## Notes

- Changing the default branch requires repository admin permissions
- After changing the default branch, users will need to update their local clones
- Pull requests and branch protection rules may need to be updated
