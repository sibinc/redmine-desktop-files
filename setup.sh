#!/bin/bash

# Define target directories
APPLICATIONS_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/redmine-desktop"

# GitHub raw file URLs
GITHUB_REPO="https://raw.githubusercontent.com/sibinc/redmine-desktop-files/main"

# Map .desktop files to correct icon names
declare -A ICON_MAPPING
ICON_MAPPING=(
  ["redmine-inprogress.desktop"]="progress.png"
  ["redmine-open.desktop"]="open.png"
  ["redmine-paused.desktop"]="paused.png"
)

# Create necessary directories
mkdir -p "$APPLICATIONS_DIR"
mkdir -p "$ICON_DIR"

# Download and update .desktop files
for FILE in "${!ICON_MAPPING[@]}"; do
  echo "Downloading $FILE..."
  curl -o "$APPLICATIONS_DIR/$FILE" -L "$GITHUB_REPO/$FILE" || { echo "Failed to download $FILE"; exit 1; }

  # Get corresponding icon file
  ICON_NAME="${ICON_MAPPING[$FILE]}"
  ICON_PATH="$ICON_DIR/$ICON_NAME"

  # Update the Icon= path inside the .desktop file
  sed -i "s|^Icon=.*|Icon=$ICON_PATH|" "$APPLICATIONS_DIR/$FILE"

  echo "Making $FILE executable..."
  chmod +x "$APPLICATIONS_DIR/$FILE"
done

# Download icons
for ICON in "${ICON_MAPPING[@]}"; do
  echo "Downloading $ICON..."
  curl -o "$ICON_DIR/$ICON" -L "$GITHUB_REPO/icons/$ICON" || { echo "Failed to download $ICON"; exit 1; }
done

echo "Installation complete
