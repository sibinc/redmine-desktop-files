#!/bin/bash

# Define text colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
BOLD="\e[1m"
RESET="\e[0m"

# Define target directories
APPLICATIONS_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/redmine-desktop"

# GitHub raw file URLs
GITHUB_REPO="https://raw.githubusercontent.com/sibinc/redmine-desktop-files/main"

# Map .desktop files to correct icon names
declare -A ICON_MAPPING=(
  ["redmine-inprogress.desktop"]="progress.png"
  ["redmine-open.desktop"]="open.png"
  ["redmine-paused.desktop"]="paused.png"
)

# Function to show progress animation
show_progress() {
  local -a frames=("|" "/" "-" "\\")
  for frame in "${frames[@]}"; do
    echo -ne "\r${YELLOW}Processing... $frame${RESET}"
    sleep 0.1
  done
}

# Display welcome message
echo -e "${BLUE}${BOLD}Welcome to the Redmine Desktop Files Installer!${RESET}"
echo -e "${YELLOW}This script will install Redmine shortcuts and icons on your system.${RESET}\n"
sleep 1

# Step 1: Create necessary directories
echo -e "${GREEN}Step 1:${RESET} Creating necessary directories..."
mkdir -p "$APPLICATIONS_DIR"
mkdir -p "$ICON_DIR"
echo -e "${GREEN}✔ Directories created successfully!${RESET}\n"
sleep 1

# Step 2: Download and install .desktop files
echo -e "${GREEN}Step 2:${RESET} Downloading and installing Redmine shortcuts..."
for FILE in "${!ICON_MAPPING[@]}"; do
  show_progress
  echo -e "\n${YELLOW}Downloading $FILE...${RESET}"
  curl -o "$APPLICATIONS_DIR/$FILE" -L "$GITHUB_REPO/$FILE" || { echo -e "${RED}✘ Failed to download $FILE${RESET}"; exit 1; }

  # Get corresponding icon file
  ICON_NAME="${ICON_MAPPING[$FILE]}"
  ICON_PATH="$ICON_DIR/$ICON_NAME"

  # Update the Icon= path inside the .desktop file
  sed -i "s|^Icon=.*|Icon=$ICON_PATH|" "$APPLICATIONS_DIR/$FILE"

  echo -e "${GREEN}✔ $FILE installed successfully!${RESET}"
done
sleep 1

# Step 3: Download and install icons
echo -e "\n${GREEN}Step 3:${RESET} Downloading icons..."
for ICON in "${ICON_MAPPING[@]}"; do
  show_progress
  echo -e "\n${YELLOW}Downloading $ICON...${RESET}"
  curl -o "$ICON_DIR/$ICON" -L "$GITHUB_REPO/icons/$ICON" || { echo -e "${RED}✘ Failed to download $ICON${RESET}"; exit 1; }
  echo -e "${GREEN}✔ $ICON installed successfully!${RESET}"
done
sleep 1

# Step 4: Making .desktop files executable
echo -e "\n${GREEN}Step 4:${RESET} Setting up permissions..."
for FILE in "${!ICON_MAPPING[@]}"; do
  chmod +x "$APPLICATIONS_DIR/$FILE"
  echo -e "${GREEN}✔ $FILE is now executable!${RESET}"
done
sleep 1

# Final success message
echo -e "\n${BLUE}${BOLD}🎉 Installation complete!${RESET}"
echo -e "${GREEN}✔ Redmine shortcuts are now available in your applications menu.${RESET}"
echo -e "${YELLOW}You can find the icons in: $ICON_DIR${RESET}"
echo -e "${YELLOW}You can find the desktop files in: $APPLICATIONS_DIR${RESET}\n"
echo -e "${BOLD}Enjoy your Redmine shortcuts! 🚀${RESET}"
