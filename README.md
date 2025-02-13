# Redmine Desktop Shortcuts Installer

Easily install Redmine desktop shortcuts with icons on your Linux system. This script downloads and places the necessary `.desktop` files and icons in the correct directories, ensuring smooth integration with your application launcher.

## 🚀 Features
- Automatically downloads and installs `.desktop` shortcut files
- Places icons in the appropriate directory
- Updates `.desktop` files to use the correct icon paths
- Ensures all necessary directories exist
- Provides progress messages and error handling

## 📦 Installation

### 1️⃣ Install Using Curl
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/sibinc/redmine-desktop-files/main/setup.sh)"
```

### 2️⃣ Install Using Wget
```bash
bash -c "$(wget -qO- https://raw.githubusercontent.com/sibinc/redmine-desktop-files/main/setup.sh)"
```

## 📂 Installed File Locations
- **Shortcut Files:** `~/.local/share/applications/`
- **Icons:** `~/.local/share/icons/redmine-desktop/`

## 🔄 How It Works
1. Downloads `.desktop` files into `~/.local/share/applications/`
2. Downloads icons into `~/.local/share/icons/redmine-desktop/`
3. Updates `.desktop` files to reference the correct icon paths
4. Ensures proper execution permissions for the shortcuts

## 🎨 Customization
If you want to modify or add more shortcuts/icons, simply update the `setup.sh` script and the repository accordingly.

## ❌ Uninstallation
To remove the installed shortcuts and icons, run:
```bash
rm -rf ~/.local/share/applications/redmine-*.desktop
rm -rf ~/.local/share/icons/redmine-desktop/
```

## 🛠 Troubleshooting
- If icons or shortcuts do not appear, try restarting your system or running:
  ```bash
  update-desktop-database ~/.local/share/applications/
  ```
- Ensure your file manager supports `.desktop` files and allows launching them.

## 📜 License
This project is open-source and available under the MIT License.

---

Enjoy seamless Redmine access from your desktop! 🚀🔥

