#!/bin/bash
# TODO Add check for DE and only install when running on KDE
# 	Test for tar, if exists, skip

# This script will copy Nordic theme files to install dirs and extract
theme_dir=/usr/share/plasma/look-and-feel
cd "$theme_dir"
# Copy from source dir to destination dir
sudo cp $(chezmoi source-path)/Files/Nordic.KDE.tar.xz .
# Extract theme
sudo tar -xvf Nordic.KDE.tar.xz
# Set correct permissions recursively
sudo chown -R root:root Nordic

# Install SDDM theme
sddm_dir=/usr/share/sddm/themes/
cd "$sddm_dir"
sudo cp $(chezmoi source-path)/Files/Nordic.KDE.SDDM.tar.xz .
sudo tar -xvf Nordic.KDE.SDDM.tar.xz