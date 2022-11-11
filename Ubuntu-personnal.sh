#!bin/bash

echo "Welcom to this configuration script, you can enter a few configuration setting and then let the script run on it's own until it finishes installing everithing. Let's go..."

dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
dconf write /org/gnome/desktop/interface/color-scheme "'default'"

dconf write /org/gnome/shell/extensions/ding/icon-size "'tiny'"
dconf write /org/gnome/shell/extension/ding/icon-size "'small'"
dconf write /org/gnome/shell/extension/ding/icon-size "'standard'"
dconf write /org/gnome/shell/extension/ding/icon-size "'large'"

dconf write /org/gnome/shell/extensions/dash-to-dock/dock-fixed "true"
dconf write /org/gnome/shell/extensions/dash-to-dock/extend-height "false"

dconf write /org/gnome/shell/extensions/dash-to-dock/dash-max-icon-size "30"
dconf write /org/gnome/extensions/dash-to-dock/isolate-workspaces "true"
dconf write /org/gnome/desktop/privacy/old-files-age "uint32 30"
dconf write /org/gnome/desktop/privacy/recent-files-max-age "-1"
dconf write /org/gnome/desktop/privacy/remove-old-trash-files "true"
dconf write /org/gnome/desktop/provacy/remove-old-temp-files "true"
dconf write /org/gnome/desktop/peripherals/mouse/speed "0.56828193832599116"

dconf write /org/gnome/shell/favorite-apps "['firefox_firefox.desktop', 'org.gnome.Nautilus.desktop']"

dconf write /org/gnome/setting-daemon/plugins/media-keys/home "['<Super>e']"

# NOTE: These instructions only work for 64 bit Debian-based
# Linux distributions such as Ubuntu, Mint etc.

# 1. Install our official public software signing key
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

# 2. Add our repository to your list of repositories
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# 3. Update your package database and install signal
sudo apt update && sudo apt install signal-desktop

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y geary gparted solaar gnome-shell-extensions gnome-software htop vim emacs python3 python3-pip jupyter r-base nextcloud-desktop retext tor signal transmission libreoffice texworks gnome-shell-extension-gsconnect vlc firefox

sudo snap refresh
sudo snap install  discord electronplayer spotify joplin
