#!bin/bash

# Script to configure a fresh ubuntu installation
echo "Welcom to this configuration script, you can enter a few configuration setting and then let the script run on it's own until it finishes installing everithing. Let's go..."

while true; do
    read -p "Do you wish to apply personnal gnome configuration? " yn
    case $yn in
        [Yy]* ) gnome_conf="yes"; break;;
        [Nn]* ) gnome_conf="no"; break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you wish to add Signal desktop application? " yn
    case $yn in
        [Yy]* ) signal="yes"; break;;
        [Nn]* ) signal="no"; break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you wish to add grub-customizer? " yn
    case $yn in
        [Yy]* ) grub_custom="yes"; break;;
        [Nn]* ) grub_custom="no"; break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Update system
sudo apt-get update
sudo apt-get -y upgrade
sudo snap refresh

# Gnome configuration
if [ "$gnome_conf" = "yes"]; then
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
fi

# Signal
if [ "$signal" = "yes"]; then
	wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
	cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
	echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
	      sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
	sudo apt-get install signal-desktop
	rm signal-desktop-keyring.gpg
fi

# gub-customizer
if [ "$grub_custom" = "yes" ]; then
	sudo add-apt-repository ppa:danielrichter2007/grub-customizer
	sudo apt-get install grub-customizer
fi

# Install commonly used packages
sudo apt-get install -y geary gparted solaar gnome-shell-extensions gnome-software htop vim emacs python3 python3-pip jupyter r-base nextcloud-desktop retext tor transmission libreoffice texworks gnome-shell-extension-gsconnect vlc firefox

sudo snap install  discord electronplayer spotify joplin gh
