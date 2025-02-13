#!/bin/bash

# 🎨 Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
RESET="\e[0m"

# 📌 Directories
APPLICATIONS_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/redmine-desktop"

# 📂 GitHub Repo (Replace with your actual GitHub repo URL)
GITHUB_REPO="https://raw.githubusercontent.com/sibinc/redmine-desktop-files/main"

# 📄 Desktop Files
FILES=(
  "redmine-inprogress.desktop"
  "redmine-open.desktop"
  "redmine-paused.desktop"
)

# 🖼️ Icon Files
ICONS=(
  "progress.png"
  "open.png"
  "paused.png"
)

echo -e "${YELLOW}🚀 Starting installation...${RESET}"

# 🔹 Create directories if they don’t exist
echo -e "${BLUE}📂 Ensuring required directories exist...${RESET}"
mkdir -p "$APPLICATIONS_DIR"
mkdir -p "$ICON_DIR"

# 🔽 Download Desktop Files
echo -e "${BLUE}💾 Downloading .desktop files...${RESET}"
for FILE in "${FILES[@]}"; do
  echo -e "📥 Downloading ${YELLOW}$FILE${RESET}..."
  curl -o "$APPLICATIONS_DIR/$FILE" -L "$GITHUB_REPO/$FILE"
  
  if [ $? -eq 0 ]; then
    echo -e "✅ ${GREEN}$FILE downloaded successfully!${RESET}"
  else
    echo -e "❌ ${RED}Failed to download $FILE. Check the URL.${RESET}"
    exit 1
  fi

  chmod +x "$APPLICATIONS_DIR/$FILE"
done

# 🔽 Download Icon Files
echo -e "${BLUE}🖼️ Downloading icons...${RESET}"
for ICON in "${ICONS[@]}"; do
  echo -e "📥 Downloading ${YELLOW}$ICON${RESET}..."
  curl -o "$ICON_DIR/$ICON" -L "$GITHUB_REPO/icons/$ICON"
  
  if [ $? -eq 0 ]; then
    echo -e "✅ ${GREEN}$ICON downloaded successfully!${RESET}"
  else
    echo -e "❌ ${RED}Failed to download $ICON. Check the URL.${RESET}"
    exit 1
  fi
done

echo -e "${GREEN}🎉 Installation complete! You can now use the Redmine shortcuts.${RESET}"
