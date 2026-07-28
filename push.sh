#!/bin/bash

set -e

echo "⚠️  WARNING: This will delete all git history and force push to GitHub!"
echo "This action cannot be undone."
read -p "Are you sure you want to continue? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Aborted."
    exit 1
fi

echo "Starting git history cleanup..."

# Get current branch name
CURRENT_BRANCH=$(git branch --show-current)
echo "Current branch: $CURRENT_BRANCH"

# Create a new orphan branch (no history)
echo "Creating new orphan branch..."
git checkout --orphan temp_branch

# Add all files
echo "Adding all files..."
git add .

# Create initial commit
echo "Creating initial commit..."
git commit -m "Initial commit"

# Delete the old branch
echo "Deleting old branch: $CURRENT_BRANCH..."
git branch -D "$CURRENT_BRANCH"

# Rename temp branch to main
echo "Renaming branch to main..."
git branch -M main

# Run garbage collection to clean up
echo "Running git gc to clean up..."
git gc --aggressive --prune=all

# Force push to GitHub
echo "Force pushing to GitHub..."
git push -f origin main

echo "✅ Done! Git history has been cleaned and pushed to GitHub."
