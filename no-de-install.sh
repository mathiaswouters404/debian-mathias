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
