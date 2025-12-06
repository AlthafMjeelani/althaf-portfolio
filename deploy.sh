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
fvm flutter build web --base-href "${BASE_HREF}" --release

# Step 2: Check if build was successful
if [ ! -d "$BUILD_DIR" ]; then
    echo "❌ Build failed: $BUILD_DIR not found"
    exit 1
fi

# Step 3: Copy build files to temporary directory before switching branches
TEMP_DIR=$(mktemp -d)
echo "📁 Copying build files to temporary directory..."
cp -r $BUILD_DIR/* "$TEMP_DIR/"

# Step 4: Save current branch and switch to gh-pages
echo "🔄 Switching to $DEPLOY_BRANCH branch..."
if ! git diff-index --quiet HEAD --; then
    git stash  # Stash any uncommitted changes
    STASHED=true
else
    STASHED=false
fi
git checkout $DEPLOY_BRANCH 2>/dev/null || git checkout -b $DEPLOY_BRANCH

# Step 5: Remove old files (except .git and .gitignore)
echo "🧹 Cleaning old files..."
find . -mindepth 1 -maxdepth 1 ! -name '.' ! -name '.git' ! -name '.gitignore' -exec rm -rf {} +

# Step 6: Copy new build files from temp directory
echo "📋 Copying build files..."
cp -r "$TEMP_DIR"/* .

# Step 7: Create .nojekyll file to prevent Jekyll processing
echo "📝 Creating .nojekyll file..."
touch .nojekyll

# Step 7.5: Copy favicon files to ensure they're included
echo "📋 Ensuring favicon files are included..."
if [ -f "web/favicon_circular.png" ]; then
  cp web/favicon_circular.png . 2>/dev/null || true
fi
if [ -f "web/favicon_circular.svg" ]; then
  cp web/favicon_circular.svg . 2>/dev/null || true
fi

# Step 8: Stage and commit
echo "💾 Committing changes..."
git add -A
if git diff --staged --quiet; then
    echo "⚠️  No changes to commit"
else
    git commit -m "Deploy Flutter web app to GitHub Pages - $(date '+%Y-%m-%d %H:%M:%S')"
    
    # Step 9: Push to GitHub
    echo "📤 Pushing to GitHub..."
    git push origin $DEPLOY_BRANCH --force
fi

# Step 10: Cleanup temp directory
rm -rf "$TEMP_DIR"

# Step 11: Switch back to original branch
echo "🔄 Switching back to $CURRENT_BRANCH branch..."
git checkout $CURRENT_BRANCH
if [ "$STASHED" = true ]; then
    git stash pop 2>/dev/null || true
fi

echo "✅ Deployment complete!"
echo "🌐 Your site should be available at: https://althafmjeelani.github.io/${REPO_NAME}/"

