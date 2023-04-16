#!/bin/bash

#read -p "Install useful apps? (y/n) " yn

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

# iterates through pacman_apps
for app in $pacman_apps ; do
echo $app
done

