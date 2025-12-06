#!/bin/bash

# Deployment script for Flutter web to GitHub Pages
# This script builds the Flutter web app and deploys it to the gh-pages branch

set -e  # Exit on error
set -o pipefail  # Exit on pipe failure

# Configuration
readonly REPO_NAME="althaf-portfolio"
readonly BASE_HREF="/${REPO_NAME}/"
readonly BUILD_DIR="build/web"
readonly DEPLOY_BRANCH="gh-pages"
readonly GITHUB_USER="althafmjeelani"
readonly SITE_URL="https://${GITHUB_USER}.github.io/${REPO_NAME}/"

# Get current branch before any operations
readonly CURRENT_BRANCH=$(git branch --show-current)

# Cleanup function
cleanup() {
    local exit_code=$?
    
    # Cleanup temp directory if it exists
    if [ -n "$TEMP_DIR" ] && [ -d "$TEMP_DIR" ]; then
        echo "🧹 Cleaning up temporary directory..."
        rm -rf "$TEMP_DIR"
    fi
    
    # Switch back to original branch if we're not already there
    if [ -n "$CURRENT_BRANCH" ] && [ "$(git branch --show-current)" != "$CURRENT_BRANCH" ]; then
        echo "🔄 Switching back to $CURRENT_BRANCH branch..."
        git checkout "$CURRENT_BRANCH" 2>/dev/null || true
        
        # Restore stashed changes if any
        if [ "${STASHED:-false}" = true ]; then
            git stash pop 2>/dev/null || true
        fi
    fi
    
    if [ $exit_code -ne 0 ]; then
        echo "❌ Deployment failed with exit code $exit_code"
        exit $exit_code
    fi
}

# Set trap for cleanup on exit
trap cleanup EXIT INT TERM

# Validation functions
check_requirements() {
    echo "🔍 Checking requirements..."
    
    # Check if git is available
    if ! command -v git &> /dev/null; then
        echo "❌ Git is not installed"
        exit 1
    fi
    
    # Check if fvm is available
    if ! command -v fvm &> /dev/null; then
        echo "❌ FVM (Flutter Version Manager) is not installed"
        exit 1
    fi
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "❌ Not in a git repository"
        exit 1
    fi
    
    # Check if we have uncommitted changes (will handle later)
    if ! git diff-index --quiet HEAD -- 2>/dev/null; then
        echo "⚠️  Warning: You have uncommitted changes (will be stashed)"
    fi
    
    echo "✅ Requirements check passed"
}

build_flutter_app() {
    echo "📦 Building Flutter web app..."
    echo "   Base href: ${BASE_HREF}"
    
    fvm flutter clean
    fvm flutter pub get
    fvm flutter build web --base-href "${BASE_HREF}" --release
    
    # Verify build was successful
    if [ ! -d "$BUILD_DIR" ]; then
        echo "❌ Build failed: $BUILD_DIR not found"
        exit 1
    fi
    
    # Check if build directory has content
    if [ -z "$(ls -A "$BUILD_DIR" 2>/dev/null)" ]; then
        echo "❌ Build failed: $BUILD_DIR is empty"
        exit 1
    fi
    
    echo "✅ Build completed successfully"
}

prepare_deployment() {
    echo "📁 Preparing deployment files..."
    
    # Create temporary directory for build files
    TEMP_DIR=$(mktemp -d)
    echo "   Using temp directory: $TEMP_DIR"
    
    # Copy build files to temporary directory
    cp -r "$BUILD_DIR"/* "$TEMP_DIR/"
    
    # Verify files were copied
    if [ -z "$(ls -A "$TEMP_DIR" 2>/dev/null)" ]; then
        echo "❌ Failed to copy build files"
        exit 1
    fi
    
    echo "✅ Deployment files prepared"
}

switch_to_deploy_branch() {
    echo "🔄 Switching to $DEPLOY_BRANCH branch..."
    
    # Stash uncommitted changes if any
    if ! git diff-index --quiet HEAD -- 2>/dev/null; then
        echo "   Stashing uncommitted changes..."
        git stash push -m "Auto-stashed before deployment $(date '+%Y-%m-%d %H:%M:%S')"
        STASHED=true
    else
        STASHED=false
    fi
    
    # Switch to or create deploy branch
    if git show-ref --verify --quiet refs/heads/"$DEPLOY_BRANCH"; then
        git checkout "$DEPLOY_BRANCH"
    else
        echo "   Creating new branch: $DEPLOY_BRANCH"
        git checkout -b "$DEPLOY_BRANCH"
    fi
    
    echo "✅ Switched to $DEPLOY_BRANCH branch"
}

deploy_files() {
    echo "📋 Deploying files..."
    
    # Remove old files (except .git and .gitignore)
    echo "   Cleaning old files..."
    find . -mindepth 1 -maxdepth 1 \
        ! -name '.' \
        ! -name '.git' \
        ! -name '.gitignore' \
        -exec rm -rf {} +
    
    # Copy new build files
    echo "   Copying new build files..."
    cp -r "$TEMP_DIR"/* .
    
    # Create .nojekyll file to prevent Jekyll processing
    echo "   Creating .nojekyll file..."
    touch .nojekyll
    
    echo "✅ Files deployed"
}

commit_and_push() {
    echo "💾 Committing changes..."
    
    # Stage all changes
    git add -A
    
    # Check if there are changes to commit
    if git diff --staged --quiet; then
        echo "⚠️  No changes to commit"
        return 0
    fi
    
    # Create commit
    local commit_message="Deploy Flutter web app to GitHub Pages - $(date '+%Y-%m-%d %H:%M:%S')"
    git commit -m "$commit_message"
    
    # Push to GitHub
    echo "📤 Pushing to GitHub..."
    git push origin "$DEPLOY_BRANCH" --force
    
    echo "✅ Changes committed and pushed"
}

# Main execution
main() {
    echo "🚀 Starting deployment to GitHub Pages..."
    echo "   Repository: $REPO_NAME"
    echo "   Deploy branch: $DEPLOY_BRANCH"
    echo "   Current branch: $CURRENT_BRANCH"
    echo ""
    
    check_requirements
    echo ""
    
    build_flutter_app
    echo ""
    
    prepare_deployment
    echo ""
    
    switch_to_deploy_branch
    echo ""
    
    deploy_files
    echo ""
    
    commit_and_push
    echo ""
    
    echo "✅ Deployment complete!"
    echo "🌐 Your site should be available at: $SITE_URL"
    echo "   (It may take a few minutes for GitHub Pages to update)"
}

# Run main function
main

