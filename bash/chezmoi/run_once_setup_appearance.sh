#!/bin/bash
# This script will copy Nordic theme files to install dirs and extract

# TODO Add check for DE and only install when running on KDE

# Install global theme
theme_dir=/usr/share/plasma/look-and-feel
nord_global=Nordic.KDE.tar.xz
cd "$theme_dir"
# Check if tar file already in directory
if [ -f "$nord_global" ] ; then
    echo "The Nordic global theme has already been installed."
else
	echo "Installing Nordic global theme"
	# Copy from source dir to destination dir
	sudo cp $(chezmoi source-path)/Files/"$nord_global" .
	# Extract theme
	sudo tar -xvf "$nord_global"
	# Set correct permissions recursively
	sudo chown -R root:root Nordic
fi

# Install SDDM theme
sddm_dir=/usr/share/sddm/themes/
nord_sddm=Nordic.KDE.SDDM.tar.xz
cd "$sddm_dir"
if [ -f "$nord_sddm" ] ; then
	echo "The SDDM theme has already been installed"
else
	echo "Installing Nordic SDDM theme"
	sudo cp $(chezmoi source-path)/Files/"$nord_sddm" .
	sudo tar -xvf "$nord_sddm"
fi

# Install Plasma theme
plasma_dir=/usr/share/plasma/desktoptheme/
nord_plasma=Nordic.KDE.Plasma.Theme.tar.xz
cd "$plasma_dir"
if [ -f "$nord_plasma" ] ; then
	echo "The Plasma theme has already been installed"
else
	echo "Installing Nordic Plasma theme"
	sudo cp $(chezmoi source-path)/Files/"$nord_plasma" .
	sudo tar -xvf "$nord_plasma"
fi

# Install Aurorae theme
aurorae_dir=/usr/share/aurorae/themes/
nord_aurorae=Nordic.KDE.Aurorae.Theme.tar.xz
# Check if dir doesn't exist, create if so
if [ ! -d "$aurorae_dir" ] ; then
	echo "Creating directory for Aurorae themes"
	sudo mkdir -p "$aurorae_dir"
fi
cd "$aurorae_dir"
if [ -f "$nord_aurorae" ] ; then
	echo "The Aurorae theme has already been installed"
else
	echo "Installing Nordic Aurorae theme"
	sudo cp $(chezmoi source-path)/Files/"$nord_aurorae" .
	sudo tar -xvf "$nord_aurorae"
fi

# Install Icons and Cursors
icons_dir=/usr/share/icons/
nord_icons=Nordic.KDE.Icons.tar.xz
nord_cursors=Nordic.KDE.Cursors.tar.xz
cd "$icons_dir"
if [ -f "$nord_icons" ] ; then
	echo "The Nordic Icons have already been installed"
else
	echo "Installing Nordic Icons theme"
	sudo cp $(chezmoi source-path)/Files/"$nord_icons" .
	sudo tar -xvf "$nord_icons"
fi
if [ -f "$nord_cursors" ] ; then
	echo "The Nordic Cursors have already been installed"
else
	echo "Installing Nordic Cursors theme"
	sudo cp $(chezmoi source-path)/Files/"$nord_cursors" .
	sudo tar -xvf "$nord_cursors"
fi

# Install Kvantum theme
kvantum_dir=/usr/share/Kvantum/
kvantum_theme=Nordic.KDE.Kvantum.Theme.tar.xz
# Check if dir doesn't exist, create if so
if [ ! -d "$kvantum_dir" ] ; then
	echo "Creating directory for Kvantum themes"
	sudo mkdir -p "$kvantum_dir"
fi
cd "$kvantum_dir"
if [ -f "$kvantum_theme" ] ; then
	echo "The Kvantum theme has already been installed"
else
	echo "Installing Nordic Kvantum theme"
	sudo cp $(chezmoi source-path)/Files/"$kvantum_theme" .
	sudo tar -xvf "$kvantum_theme"
fi

# Install color-scheme
color_scheme_dir=/usr/share/color-schemes/
color_scheme=Nordic.colors
cd "$color_scheme_dir"
if [ -f "$color_scheme" ] ; then
	echo "The color-scheme has already been installed"
else
	echo "Installing Nordic color-scheme"
	sudo cp $(chezmoi source-path)/Files/"$color_scheme" .
fi