#!/bin/bash

# List of packages to remove
packages=(
    akregator
    ark
    "contact-theme-editor"
    "contact-print-theme-editor"
    "crashed-processes-viewer"
    dragonplayer
    "emoji-selector"
    "firefox-esr"
    "gimp"
    gwenview
    help
    imagemagick
    juk
    "kaddressbook"
    kate
    kcalc
    "kdeconnect"
    "kdeconnect-sms"
    kfind
    kmag
    kmail
    "kmail-header-theme-editor"
    kmousetool
    kmouth
    knotes
    konqueror
    kontrast
    korganizer
    ktnef
    kwalletmanager
    kwrite
    "menu-editor"
    okular
    "open-on-connected-device-via-kdeconnect"
    "pim-data-exporter"
    "sieve-editor"
    spectacle
    sweeper
    uxterm
    xterm
)

# Start the process of removing packages
echo "Removing the following bloat packages..."
for package in "${packages[@]}"; do
    if dpkg -l | grep -q "$package"; then
        echo "Removing $package..."
        apt-get remove --purge -y "$package"
    else
        echo "$package is not installed, skipping."
    fi
done

# Clean up residual configuration files
echo "Cleaning up residual configuration files..."
apt-get autoremove --purge -y
apt-get clean

# Update package lists
echo "Updating package lists..."
apt update

echo "All specified bloat has been removed."
