# Debian-mathias

## Step 1: Download Debian ISO

1) Go to [Debian Website](https://www.debian.org/)
2) Click 'Download' button
3) Open Balena Etcher
4) Flash ISO on USB Drive
5) Boot from USB Drive

## Step 2: Install Debian

1) Select 'Graphical install'
2) Configure the network
3) Enter the hostname
4) Enter Root password
5) Configure user
6) Configure the clock
7) Partition disks
    1) Select 'use entire disk'
8) Configure the package manager
9) Select 'no' for package usage survey
10) At software selection:
    - If you want KDE desktop environment:
      1) Select 'Debian desktop environment'
      2) Select 'KDE Plasma'
      3) Select 'standard system utilities'
    
    - If you want NO desktop environment:
      1) Only select 'standard system utilities'

## Step 3: Add user to sudoers file
```bash
su root 
nano /etc/sudoers
```

Then add the user below admin user like below syntax.
```bash
user_name ALL=(ALL)  ALL
```

## Step 4: Configure Debian System
  ```bash
  sudo apt install git -y
  git clone https://github.com/mathiaswouters404/debian-mathias
  sudo su -
  cd /home/$(id -u -n 1000)/debian-mathias
  chmod +x install.sh
  chmod +x scripts/remove-bloat.sh
  ./install.sh
  ```
