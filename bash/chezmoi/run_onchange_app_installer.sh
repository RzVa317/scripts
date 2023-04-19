#!/bin/bash
# This script will be called by chezmoi on first-runs
# For now it will prompt to install any uninstalled apps
# Later on should add flag to install all

# Apps to install w/ pacman
pacman_apps="
obsidian
barrier
tmux
ffmpegthumbs
xclip
smb4k 
solaar
yakuake
figlet
tailscale
git-filter-repo"

# Apps from AUR to install w/ yay
yay_apps="
cryptomator-bin
remmina-git
visual-studio-code-bin
nordvpn"

for app in $pacman_apps; do
    # Checking for app in $pacman_apps, for clarity:
    # > /dev/null sends response (app installed) to the void
    # 2> /dev/null sends error (app not installed) to the void
    if pacman -Qi $app > /dev/null 2> /dev/null; then
        # Installed
        echo "$app is already installed"
    else
        # Install and accept default options
        sudo pacman -S --noconfirm $app
    fi
done

# Iterate through yay_apps
for app in $yay_apps; do
    # If $app is installed
    if yay -Qi $app > /dev/null 2> /dev/null; then
        # Installed
        echo "$app is installed already"
    else
        # Install and accept default options
        yay -S --noconfirm $app
    fi
done