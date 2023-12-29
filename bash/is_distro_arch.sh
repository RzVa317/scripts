#!/bin/bash
# Functions and vars to use w/ bash scripts
# Set color variables using tput
# red=$(tput setaf 1)
green=$(tput setaf 2)
# bold=$(tput bold)
reset=$(tput sgr0)
# Function that checks if running distro is Arch
is_distro_arch() {
	distro=$(grep ID_LIKE /etc/os-release | awk -F'ID_LIKE=' '{print $2}')
	echo "${green}=== Running on $distro ===${reset}"
	if [[ "$distro" == '"arch"' ]]
		then return 0
		else return 1
	fi
}