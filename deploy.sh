#!/bin/bash

# Deploy the portfolio site (site/) to GitHub Pages (gh-pages branch).
# The site is plain HTML/CSS/JS, so there is no build step.
#
# Usage:  ./deploy.sh
# Live at: https://althafmjeelani.github.io/althaf-portfolio/
#
# The previous Flutter web version is still in lib/ and web/.
# To deploy that instead, run:  ./deploy.sh --flutter

set -e

REPO_NAME="althaf-portfolio"
CURRENT_BRANCH=$(git branch --show-current)
DEPLOY_BRANCH="gh-pages"

if [ "$1" == "--flutter" ]; then
    echo "📦 Building Flutter web app..."
    fvm flutter clean
    fvm flutter pub get
    fvm flutter build web --base-href "/${REPO_NAME}/" --release
    SRC_DIR="build/web"
else
    SRC_DIR="site"
fi

if [ ! -f "$SRC_DIR/index.html" ]; then
    echo "❌ $SRC_DIR/index.html not found"
    exit 1
fi

echo "🚀 Deploying $SRC_DIR to $DEPLOY_BRANCH..."

# Copy the site to a temp folder before switching branches
TEMP_DIR=$(mktemp -d)
cp -r "$SRC_DIR"/. "$TEMP_DIR/"

# Stash uncommitted work
if ! git diff-index --quiet HEAD --; then
    git stash
    STASHED=true
else
    STASHED=false
fi

git checkout $DEPLOY_BRANCH 2>/dev/null || git checkout --orphan $DEPLOY_BRANCH

# Replace everything except .git
find . -mindepth 1 -maxdepth 1 ! -name '.git' -exec rm -rf {} +
cp -r "$TEMP_DIR"/. .
touch .nojekyll

git add -A
if git diff --staged --quiet; then
    echo "⚠️  No changes to deploy"
else
    git commit -m "Deploy portfolio - $(date '+%Y-%m-%d %H:%M:%S')"
    echo "📤 Pushing to GitHub..."
    git push origin $DEPLOY_BRANCH --force
fi

rm -rf "$TEMP_DIR"
git checkout "$CURRENT_BRANCH"
if [ "$STASHED" = true ]; then
    git stash pop 2>/dev/null || true
fi

echo "✅ Deployment complete!"
echo "🌐 https://althafmjeelani.github.io/${REPO_NAME}/"
