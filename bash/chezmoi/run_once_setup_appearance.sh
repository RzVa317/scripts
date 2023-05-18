#!/bin/bash
# This script will copy Nordic theme files to install dirs and extract

# TODO Add check for DE and only install when running on KDE

# Install global theme
echo "Installing Nordic global theme"
theme_dir=/usr/share/plasma/look-and-feel
nord_global=Nordic.KDE.tar.xz
cd "$theme_dir"
# Check if tar file already in directory
if [ -f "$nord_global" ] ; then
    echo "The global theme has already been installed."
else
	# Copy from source dir to destination dir
	sudo cp $(chezmoi source-path)/Files/"$nord_global" .
	# Extract theme
	sudo tar -xvf "$nord_global"
	# Set correct permissions recursively
	sudo chown -R root:root Nordic
fi

# Install SDDM theme
echo "Installing Nordic SDDM theme"
sddm_dir=/usr/share/sddm/themes/
nord_sddm=Nordic.KDE.SDDM.tar.xz
cd "$sddm_dir"
if [ -f "$nord_sddm" ] ; then
	echo "The SDDM theme has already been installed"
else
	sudo cp $(chezmoi source-path)/Files/"$nord_sddm" .
	sudo tar -xvf "$nord_sddm"
fi