#!/bin/bash
# Functions and vars to use w/ bash scripts
# Set color variables using tput
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)
check_group_membership() {
    # Check if current user is in the group param
	local group="$1"
	if id -nGz "$USER" | grep -qzxF "$group"
	then
		echo "${green}User '$USER' already belongs to group '$group'${reset}"
        return 0
	else
        if sudo gpasswd -a "$USER" "$group"
        then
            echo "${green}Successfully added '$USER' to '$group'${reset}"
            return 0
        else
		    echo "${red}Unable to add '$USER' to '$group'${reset}"
            return 1
        fi
	fi
}