#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

# ASCII ART Welcoming
cat << "EOF"
 _______   _______ .______    __       ___      .__   __.                     
|       \ |   ____||   _  \  |  |     /   \     |  \ |  |                     
|  .--.  ||  |__   |  |_)  | |  |    /  ^  \    |   \|  |                     
|  |  |  ||   __|  |   _  <  |  |   /  /_\  \   |  . `  |                     
|  '--'  ||  |____ |  |_)  | |  |  /  _____  \  |  |\   |                     
|_______/ |_______||______/  |__| /__/     \__\ |__| \__|                     
                                                                              
.___  ___.      ___   .___________. __    __   __       ___           _______.
|   \/   |     /   \  |           ||  |  |  | |  |     /   \         /       |
|  \  /  |    /  ^  \ `---|  |----`|  |__|  | |  |    /  ^  \       |   (----`
|  |\/|  |   /  /_\  \    |  |     |   __   | |  |   /  /_\  \       \   \    
|  |  |  |  /  _____  \   |  |     |  |  |  | |  |  /  _____  \  .----)   |   
|__|  |__| /__/     \__\  |__|     |__|  |__| |__| /__/     \__\ |_______/    
                                                                              
EOF

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
apt install kitty rofi zip unzip dnsutils whois curl wget build-essential net-tools ufw gufw neofetch flameshot vim nano ca-certificates gnupg cmake pkg-config libevdev-dev libudev-dev libconfig++-dev libglib2.0-dev -y

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
usermod -aG docker $username
newgrp docker

# Install docker desktop:
wget -O https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64
apt-get update
apt-get install -y ./docker-desktop-amd64.deb
rm docker-desktop-amd64.deb

# Install Flameshot:
apt install flameshot -y

# Install gedit:
snap install gedit

# Install gparted:
apt install gparted -y

# Install Grub Customizer:
add-apt-repository ppa:trebelnik-stefina/grub-customizer
apt update
apt install grub-customizer -y

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
systemctl restart logid

# Install spotify:
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
apt update
apt install spotify-client -y

# Install surfshark:
curl -f https://downloads.surfshark.com/linux/debian-install.sh --output surfshark-install.sh
sh surfshark-install.sh
apt-get update
apt-get --only-upgrade install surfshark -y

# Install twingate:
curl -s https://binaries.twingate.com/client/linux/install.sh | sudo bash

# Install VS Code:
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
install -o root -g root -m 644 microsoft.gpg /etc/apt/keyrings/microsoft-archive-keyring.gpg
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt update
apt-get install code -y

# Install Onlyoffice:
snap install onlyoffice-desktopeditors

# Delete LibreOffice:
apt-get remove --purge "libreoffice*"
apt-get clean
apt-get autoremove

# Install postman:
snap install postman

# Install figma:
snap install figma-linux

# Install Remmina:
snap install remmina

# Install Timeshift:
apt install timeshift -y

# Install Qemu - Virt manager:
apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager -y
adduser $username libvirt
adduser $username kvm
systemctl start libvirtd
systemctl enable libvirtd

# Delete konsole :
apt uninstall konsole -y

# Configure UFW:
ufw allow ssh
ufw allow http
ufw allow https
ufw enable

# Setup bootloader
git clone https://github.com/mathiaswouters404/bootloader-theme
cd bootloader-theme
sudo ./install.sh
cd ../debian-mathias
rm -rf bootloader-theme

# End
cat << "EOF"
 _______ .__   __.  _______  
|   ____||  \ |  | |       \ 
|  |__   |   \|  | |  .--.  |
|   __|  |  . `  | |  |  |  |
|  |____ |  |\   | |  '--'  |
|_______||__| \__| |_______/ 
EOF

echo "Please execute the following command to configure twingate: sudo twingate setup"
