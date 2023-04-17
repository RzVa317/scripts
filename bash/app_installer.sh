#!/bin/bash

pacman_apps="obsidian
barrier
tmux
ffmpegthumbs
xclip
smb4k 
solaar
yakuake
"
yay_apps="cryptomator-bin
remmina-git
visual-studio-code-bin
nordvpn
"

read -p "Install useful pacman apps as sudo? (y/n) " yn

case $yn in
	y )
    # Iterate through pacman_apps
    for app in $pacman_apps ; do
        # Checking for $app, for clarity:
        # > /dev/null sends response (app installed) to the void
        # 2> /dev/null sends error (app not installed) to the void
        if pacman -Qi $app > /dev/null 2> /dev/null ; then
            # Installed
            echo "$app is already installed"
        else
            # Not installed
            #sudo pacman -S $app
            echo "$app is not installed"
        fi
    done;;
	n ) echo "Not installing anything";;
	* ) echo continue;;
esac