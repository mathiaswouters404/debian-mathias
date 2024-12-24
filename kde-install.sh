#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

# Let user choose the option of the terminal

echo "Please select the terminal : "

browser_option=("Terminator" "...")
select web in "${browser_option[@]}"; do
  if [ "$web" = "Terminator" ]; then
    web_install="Terminator"
    break
  elif [ "$web" = "..." ]; then
    web_install="..."
    break
  fi
done

# Update packages list and update system
apt update
apt upgrade -y

# Moving wallpapers to Pictures
cd $builddir
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Pictures/wallpapers
cp -R wallpapers/* /home/$username/Pictures/wallpapers/
chown -R $username:$username /home/$username

# Install Snap
apt update
apt install snapd -y
snap install snapd

# Installing packages: 
apt install rofi unzip curl wget build-essential neofetch flameshot vim nano ca-certificates gnupg cmake pkg-config libevdev-dev libudev-dev libconfig++-dev libglib2.0-dev -y

# Install firefox:
if dpkg -l | grep -q firefox; then
    echo "Firefox is already installed. Skipping installation."
else
    echo "Firefox is not installed. Installing..."
    sudo apt update && sudo apt install -y firefox
fi

# Install bitwarden:
snap install bitwarden

# Install docker:
wget -O docker.sh https://get.docker.com/
bash docker.sh
rm docker.sh

# Add user to docker group:
usermod -aG docker "$USER"
newgrp docker

# Install docker desktop:
wget -O https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64
apt-get update
apt-get install -y ./docker-desktop-amd64.deb
rm docker-desktop-amd64.deb

# Install UFW:
apt install ufw

# Configure UFW:
ufw allow ssh
ufw allow http
ufw allow https
ufw enable

# Install Flameshot:
apt install flameshot

# Install gedit:
snap install gedit

# Install gparted:
apt install gparted

# Install Grub Customizer:
add-apt-repository ppa:trebelnik-stefina/grub-customizer
apt update
apt install grub-customizer

# Install Logiops:
git clone https://github.com/PixlOne/logiops
cd logiops
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
make install
touch /etc/logid.cfg
systemctl enable --now logid
cd ../../debian-mathias
rm -rf logiops
cp logid.cfg /etc/

# Install spotify:


# Install surfshark:


# Install twingate:


# Install VS Code:


# Install Onlyoffice --> delete default office apps:


# Install postman:


# Install figma:


# Install Remmina:


# Install Timeshift:


# Install Qemu - Virt manager:


# Install chosen terminal --> also delete konsole :

