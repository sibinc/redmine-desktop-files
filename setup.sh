#!/bin/bash

# 🎨 Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
RESET="\e[0m"

# 📂 Directories
APPLICATIONS_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/redmine-desktop"

# 🔗 GitHub Repo (Update this with your actual GitHub username and repo)
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

# Function to download a file and retry if empty
download_file() {
  local url="$1"
  local dest="$2"
  local file_name=$(basename "$dest")

  echo -e "📥 Downloading ${YELLOW}$file_name${RESET}..."
  curl -s -o "$dest" -L "$url"

  # Check if file is empty
  if [[ ! -s "$dest" ]]; then
    echo -e "⚠️ ${RED}Warning: $file_name seems empty. Retrying...${RESET}"
    curl -s -o "$dest" -L "$url"

    # If still empty, show an error and exit
    if [[ ! -s "$dest" ]]; then
      echo -e "❌ ${RED}Failed to download $file_name properly. Check the URL.${RESET}"
      exit 1
    fi
  fi

  echo -e "✅ ${GREEN}$file_name downloaded successfully!${RESET}"
}

# 🔽 Download Desktop Files
echo -e "${BLUE}💾 Downloading .desktop files...${RESET}"
for FILE in "${FILES[@]}"; do
  download_file "$GITHUB_REPO/$FILE" "$APPLICATIONS_DIR/$FILE"
  chmod +x "$APPLICATIONS_DIR/$FILE"
done

# 🔽 Download Icon Files
echo -e "${BLUE}🖼️ Downloading icons...${RESET}"
for ICON in "${ICONS[@]}"; do
  download_file "$GITHUB_REPO/icons/$ICON" "$ICON_DIR/$ICON"
done

# 🔄 Update `Icon=` paths inside .desktop files
echo -e "${BLUE}🛠️ Updating .desktop files with correct icon paths...${RESET}"
for i in "${!FILES[@]}"; do
  FILE="$APPLICATIONS_DIR/${FILES[i]}"
  ICON_PATH="$ICON_DIR/${ICONS[i]}"

  if [ -f "$FILE" ]; then
    sed -i "s|^Icon=.*|Icon=$ICON_PATH|" "$FILE"
    echo -e "🔧 Updated icon path in ${YELLOW}${FILES[i]}${RESET}"
  else
    echo -e "⚠️ ${RED}${FILES[i]} not found. Skipping icon update.${RESET}"
  fi
done

echo -e "${GREEN}🎉 Installation complete! You can now use the Redmine shortcuts.${RESET}"
