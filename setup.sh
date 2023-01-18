#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

# Creating variables
echo Enter username:
read username

echo Please enter your password:
read passwd

builddir=$(pwd)

#Creating users
dnf install openssl
useradd -m -g wheel -p `openssl passwd -1 $passwd` $username

# Updating Packages
dnf upgrade

# Creating dirs and moving configs
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home/$username/Pictures
mkdir -p /usr/share/sddm/themes
mkdir -p /home/$username/.local/share/applications
mkdir -p /home/$username/.scripts/
cp .Xresources /home/$username
cp .Xnord /home/$username
cp -R .config/* /home/$username/.config/
cp -R .local/share/applications/* /home/$username/.local/share/applications
cp -R .scripts/* /home/$username/.scripts/
chown -R $username:$username /home/$username
tar -xzvf sugar-candy.tar.gz -C /usr/share/sddm/themes
mv /home/$username/.config/sddm.conf /etc/sddm.conf

# Installing sugar-candy dependencies
dnf install libqt5svg5 qml-module-qtquick-controls qml-module-qtquick-controls2 -y

# Installing Packages
dnf copr enable atim/alacritty
dnf install fish sddm wget unzip zip htop nano neofetch python3 alacritty nvim lsd zoxide

# Starship
curl -sS https://starship.rs/install.sh | sh

# customizations
./customizations.sh

# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git

cd $builddir

# Phinger icons
wget -cO- https://github.com/phisch/phinger-cursors/releases/latest/download/phinger-cursors-variants.tar.bz2 | tar xfj - -C /usr/share/icons

# Install brave-browser
dnf install dnf-plugins-core
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install brave-browser

# Enable graphical login and change target from CLI to GUI
systemctl enable sddm
systemctl set-default graphical.target