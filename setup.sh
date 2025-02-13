#!/bin/bash

# Target directory
TARGET_DIR="$HOME/.local/share/applications-test"

# GitHub raw file URLs
GITHUB_REPO="https://raw.githubusercontent.com/sibinc/redmine-desktop-files/main"
FILES=(
  "$GITHUB_REPO/redmine-inprogress.desktop"
  "$GITHUB_REPO/redmine-open.desktop"
  "$GITHUB_REPO/redmine-paused.desktop"
)

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Download and install each file
for FILE_URL in "${FILES[@]}"; do
  FILE_NAME=$(basename "$FILE_URL")
  DEST_PATH="$TARGET_DIR/$FILE_NAME"
  
  echo "Downloading $FILE_NAME..."
  curl -o "$DEST_PATH" -L "$FILE_URL" || { echo "Failed to download $FILE_NAME"; exit 1; }
  
  echo "Making $FILE_NAME executable..."
  chmod +x "$DEST_PATH"
done

echo "Installation complete. The .desktop files are now available in $TARGET_DIR"
