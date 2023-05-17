#!/bin/bash
# TODO Add check for DE and only install when running on KDE
# This script will copy Nordic.KDE.tar.xz to theme dir and extract
cd ~/.local/share/plasma/desktoptheme
# Copy from source dir to destination dir
cp $(chezmoi source-path)/Files/Nordic.KDE.tar.xz .
# Extract theme
tar -xvf Nordic.KDE.tar.xz