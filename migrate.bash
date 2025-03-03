#!/bin/bash

set -e  # Exit on error

# Ensure required environment variables are set
if [ -z "$GITLAB_REPO" ] || [ -z "$GITHUB_OWNER" ] || [ -z "$GITHUB_REPO" ] || [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: Required environment variables are not set."
  exit 1
fi

# Remove existing repo_mirror folder (if any)
echo "Removing existing repo_mirror folder (if any)..."
rm -rf repo_mirror

# Clone from GitLab
echo "Cloning from GitLab..."
git clone --bare "https://gitlab.com/${GITLAB_REPO}.git" repo_mirror
cd repo_mirror

# Add GitHub remote
echo "Adding GitHub remote..."
git remote add github "https://${GITHUB_TOKEN}@github.com/${GITHUB_OWNER}/${GITHUB_REPO}.git"

# Authenticate GitHub session
git config --global credential.helper store
echo "https://${GITHUB_TOKEN}:@github.com" > ~/.git-credentials
chmod 600 ~/.git-credentials

# Push all branches/tags
echo "Pushing all branches/tags..."
git push --mirror github

# Cleanup
echo "Removing GitHub credentials file..."
rm -f ~/.git-credentials

# echo "Done!"
    
#     The script is pretty straightforward. It clones the GitLab repository, adds the GitHub remote, pushes all branches and tags, and cleans up. 
#     The script requires the following environment variables: 
    
#     GITLAB_REPO : The GitLab repository path (e.g.,  my-org/my-repo ). 
#     GITHUB_OWNER : The GitHub repository owner (e.g.,  my-org ). 
#     GITHUB_REPO : The GitHub repository name (e.g.,  my-repo ). 
#     GITHUB_TOKEN : A GitHub personal access token with the  repo  scope. 
    
#     You can run the script like this: 
#     $ GITLAB_REPO=my-org/my-repo GITHUB_OWNER=my-org GITHUB_REPO=my-repo GITHUB_TOKEN=your-github-token bash migrate.bash
    
#     The script will clone the GitLab repository, add the GitHub remote, push all branches and tags, and clean up. 
#     Conclusion 
#     In this article, we learned how to migrate a GitLab repository to GitHub. We used the GitHub API to create a new repository and then pushed the GitLab repository to the new GitHub repository. 
#     The process is straightforward and can be automated using a script. 
#     I hope you found this article helpful. If you have any questions or feedback, please let me know in the comments below. 
#     Happy coding! 
#     Peer Review Contributions by:  Lalithnarayan C