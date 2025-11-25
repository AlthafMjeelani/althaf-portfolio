#!/bin/bash

# Deployment script for Flutter web to GitHub Pages
# This script builds the Flutter web app and deploys it to the gh-pages branch

set -e  # Exit on error

REPO_NAME="althaf-portfolio"
BASE_HREF="/${REPO_NAME}/"
CURRENT_BRANCH=$(git branch --show-current)
BUILD_DIR="build/web"
DEPLOY_BRANCH="gh-pages"

echo "🚀 Starting deployment to GitHub Pages..."

# Step 1: Build Flutter web app
echo "📦 Building Flutter web app..."
fvm flutter clean
fvm flutter pub get
fvm flutter build web --release --base-href="${BASE_HREF}"

# Step 2: Check if build was successful
if [ ! -d "$BUILD_DIR" ]; then
    echo "❌ Build failed: $BUILD_DIR not found"
    exit 1
fi

# Step 3: Save current branch and switch to gh-pages
echo "🔄 Switching to $DEPLOY_BRANCH branch..."
git stash  # Stash any uncommitted changes
git checkout $DEPLOY_BRANCH 2>/dev/null || git checkout -b $DEPLOY_BRANCH

# Step 4: Remove old files (except .git and .gitignore)
echo "🧹 Cleaning old files..."
find . -mindepth 1 -maxdepth 1 ! -name '.git' ! -name '.gitignore' -exec rm -rf {} +

# Step 5: Copy new build files
echo "📋 Copying build files..."
cp -r $BUILD_DIR/* .

# Step 6: Remove build artifacts that shouldn't be in gh-pages
rm -f .last_build_id .nojekyll 2>/dev/null || true

# Step 7: Stage and commit
echo "💾 Committing changes..."
git add -A
git commit -m "Deploy Flutter web app to GitHub Pages - $(date '+%Y-%m-%d %H:%M:%S')" || echo "No changes to commit"

# Step 8: Push to GitHub
echo "📤 Pushing to GitHub..."
git push origin $DEPLOY_BRANCH

# Step 9: Switch back to original branch
echo "🔄 Switching back to $CURRENT_BRANCH branch..."
git checkout $CURRENT_BRANCH
git stash pop 2>/dev/null || true

echo "✅ Deployment complete!"
echo "🌐 Your site should be available at: https://althafmjeelani.github.io/${REPO_NAME}/"

