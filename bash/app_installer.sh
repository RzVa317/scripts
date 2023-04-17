#!/bin/bash
# This script will be called by chezmoi on first-runs

# Apps to install w/ pacman
pacman_apps="obsidian
barrier
tmux
ffmpegthumbs
xclip
smb4k 
solaar
yakuake"

# Apps from AUR to install w/ yay
yay_apps="cryptomator-bin
remmina-git
visual-studio-code-bin
nordvpn"

# Prompt to install pacman_apps
read -p "Install useful apps w/ pacman? (y/n) " yn
case $yn in
	y )
        # Iterate through pacman_apps
        for app in $pacman_apps; do
            # Checking for app in $pacman_apps, for clarity:
            # > /dev/null sends response (app installed) to the void
            # 2> /dev/null sends error (app not installed) to the void
            if pacman -Qi $app > /dev/null 2> /dev/null; then
                # Installed
                echo "$app is already installed"
            else
                # Not installed
                #sudo pacman -S $app
                echo "$app is not installed"
            fi
        done;;
	n ) echo "Not installing anything through pacman";;
esac

# Prompt to install yay_apps
read -p "Install useful apps w/ yay? (y/n) " yn
case $yn in
    y )
        # Iterate through yay_apps
        for app in $yay_apps; do
            if yay -Qi $app > /dev/null 2> /dev/null; then
                # Installed
                echo "$app is installed already"
            else
                # Not installed
                echo "$app is not installed"
            fi
        done;;
    n ) echo "Not installing anything through yay";;
esac