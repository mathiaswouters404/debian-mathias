#!/bin/bash

# List of packages to remove
packages=(
    akregator
    ark
    "contact-theme-editor"
    "contact-print-theme-editor"
    drkonqi
    dragonplayer
    "firefox-esr"
    "gimp"
    gwenview
    imagemagick
    juk
    "kaddressbook"
    kate
    kcalc
    "kdeconnect"
    "kdeconnect-sms"
    kde-spectacle
    kfind
    khelpcenter
    kmag
    kmail
    "kmail-header-theme-editor"
    kmenuedit
    kmousetool
    kmouth
    knotes
    konqueror
    kontrast
    korganizer
    ktnef
    kwalletmanager
    kwrite
    okular
    "open-on-connected-device-via-kdeconnect"
    "pim-data-exporter"
    "sieve-editor"
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
