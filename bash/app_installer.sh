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

#echo "pacman apps are: $pacman_apps"
#echo "yay apps are: $yay_apps"

read -p "Install useful pacman apps as sudo? (y/n) " yn

case $yn in
	y )
    # iterates through pacman_apps
    for app in $pacman_apps ; do
        echo "Testing $app"
        sudo pacman -S $app
    done;;
	n ) echo "Not installing anything";;
	* ) echo continue;;
esac