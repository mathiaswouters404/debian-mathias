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

# Installing packages: 
apt install rofi unzip wget build-essential neofetch flameshot vim nano -y

# Install firefox:
if dpkg -l | grep -q firefox; then
    echo "Firefox is already installed. Skipping installation."
else
    echo "Firefox is not installed. Installing..."
    sudo apt update && sudo apt install -y firefox
fi

# Install :


# Install :


# Install :


# Install :


# Install :


# Install :


# Install :


# Install :


# Install :

# Install chosen terminal --> also delete konsole :

