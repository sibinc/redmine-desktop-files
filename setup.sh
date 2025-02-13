#!/bin/bash

# Define target directories
APPLICATIONS_DIR="$HOME/.local/share/applications"
ICON_DIR="$APPLICATIONS_DIR/redmine-desktop"

# GitHub raw file URLs
GITHUB_REPO="https://raw.githubusercontent.com/sibinc/redmine-desktop-files/main"

# List of desktop files
DESKTOP_FILES=(
  "redmine-inprogress.desktop"
  "redmine-open.desktop"
  "redmine-paused.desktop"
)

# List of icons (update this if you add more icons)
ICONS=(
  "progress.png"
  "open.png"
  "paused.png"
)

# Create necessary directories
mkdir -p "$APPLICATIONS_DIR"
mkdir -p "$ICON_DIR"

# Download .desktop files
for FILE in "${DESKTOP_FILES[@]}"; do
  echo "Downloading $FILE..."
  curl -o "$APPLICATIONS_DIR/$FILE" -L "$GITHUB_REPO/$FILE" || { echo "Failed to download $FILE"; exit 1; }
  
  echo "Making $FILE executable..."
  chmod +x "$APPLICATIONS_DIR/$FILE"
done

# Download icons
for ICON in "${ICONS[@]}"; do
  echo "Downloading $ICON..."
  curl -o "$ICON_DIR/$ICON" -L "$GITHUB_REPO/icons/$ICON" || { echo "Failed to download $ICON"; exit 1; }
done

echo "Installation complete. Desktop files are in $APPLICATIONS_DIR, and icons are in $ICON_DIR."
