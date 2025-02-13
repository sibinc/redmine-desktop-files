#!/bin/bash

# Define target directories
APPLICATIONS_DIR="$HOME/.local/share/applications-test"
ICON_DIR="$HOME/.local/share/icons/redmine-desktop"

# GitHub raw file URLs
GITHUB_REPO="https://raw.githubusercontent.com/sibinc/redmine-desktop-files/main"

# List of desktop files
DESKTOP_FILES=(
  "redmine-inprogress.desktop"
  "redmine-open.desktop"
  "redmine-paused.desktop"
)

# List of icons
ICONS=(
  "progress.png"
  "open.png"
  "paused.png"
)

# Create necessary directories
mkdir -p "$APPLICATIONS_DIR"
mkdir -p "$ICON_DIR"

# Download and update .desktop files
for FILE in "${DESKTOP_FILES[@]}"; do
  echo "Downloading $FILE..."
  curl -o "$APPLICATIONS_DIR/$FILE" -L "$GITHUB_REPO/$FILE" || { echo "Failed to download $FILE"; exit 1; }

  # Update the Icon= path inside the .desktop file
  ICON_NAME="${FILE%.desktop}.png"
  sed -i "s|^Icon=.*|Icon=$ICON_DIR/$ICON_NAME|" "$APPLICATIONS_DIR/$FILE"

  echo "Making $FILE executable..."
  chmod +x "$APPLICATIONS_DIR/$FILE"
done

# Download icons
for ICON in "${ICONS[@]}"; do
  echo "Downloading $ICON..."
  curl -o "$ICON_DIR/$ICON" -L "$GITHUB_REPO/icons/$ICON" || { echo "Failed to download $ICON"; exit 1; }
done

echo "Installation complete. Desktop files are in $APPLICATIONS_DIR, and icons are in $ICON_DIR."
