#!/bin/bash
# This script is a launcher and installer for AvaConfigurator

# Global variables
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
cyan=$(tput setaf 6)
bold=$(tput bold)
reset=$(tput sgr0)
ps7installer=powershell_7.3.6-1.deb_amd64.deb

# Check for powershell update based on var above
check_for_pwsh_update() {
	pwsh_ver=$(dpkg -s powershell | grep -oP 'Version: \K\d+\.\d+\.\d+-\d+\.deb')
	pwsh_new=$(echo $ps7installer  | grep -oP '\K\d+\.\d+\.\d+-\d+\.deb')
	if [ "$pwsh_ver" \< "$pwsh_new" ]
	then return 1
	else return 0
	fi
}
download_ps7() {
	# Download PS7
	echo "${green}Downloading PowerShell 7${reset}"
	cd "$HOME" || exit 1
	# Check for existing file
	if [[ ! -f "$ps7installer" ]]
	# If not found
	then
		if wget -q --show-progress "https://github.com/PowerShell/PowerShell/releases/download/v7.3.6/$ps7installer"
		then return 0
		else return 1
		fi
	else return 0
	fi
}
install_ps7() {
	echo "${green}Installing PowerShell 7${reset}"
	# Install PS7
	if sudo dpkg -i $ps7installer &> /dev/null
	then return 0
	else return 1
	fi
}
download_and_install_ps7() {
	# wget PS7
	if ! download_ps7
	then
		echo "${red}Failed to download PS7 install file${reset}"
		exit 1
	fi
	# dpkg PS7
	if ! install_ps7
	then
		echo "${red}Failed to install PowerShell 7${reset}"
		exit 1
	fi
}
check_excel() {
	if pwsh -Command "if ((Get-Module -ListAvailable).Name.Contains('ImportExcel')){Exit 0}else{Exit 1}"
	then return 0
	else return 1
	fi
}
install_excel() {
	echo "${green}Installing ImportExcel PS module${reset}"
	# Change PSGallery installation policy
	pwsh -Command Set-PSRepository -InstallationPolicy Trusted -Name PSGallery
	pwsh -Command Install-Module -Name ImportExcel
	# Check for excel again to return proper code
	if check_excel ; then return 0 ; else return 1 ; fi ;
}
install_packages() {
	echo "${green}Installing prereqs${reset}"
	if sudo apt-get install -y git nmap figlet toilet &> /dev/null
	then return 0
	else return 1
	fi
}
check_sshpub() {
	keyfile=~/.ssh/id_ed25519
	if [ -f $keyfile ]
	then return 0
	else return 1
	fi
}
create_ed25519() {
	echo "${green}Creating new SSH key${reset}"
	echo "Enter a name for your new key"
	read -r keyname
	if ssh-keygen -t ed25519 -C "$keyname" -f $keyfile -N '' &> /dev/null
	then 
		create_sshconfig
		return 0
	else return 1
	fi
}
create_sshconfig() {
	echo "${green}Creating SSH config${reset}"
	cd "$HOME/.ssh" || exit 1
	{ echo "Host github.com" ;
	echo "$(printf '\t')Hostname github.com" ;
	echo "$(printf '\t')StrictHostKeyChecking no" ; } >> config
}
check_repo() {
	repo="AvaConfigurator"
	# Check for repo in current dir
	if ! cd "$HOME/$repo" 2> /dev/null
	then return 1
	else return 0
	fi
}
clone_repo() {
	cd "$HOME" || exit 1
	echo "${green}Cloning $repo repo to $(pwd)${reset}"
	if ! git clone --quiet "git@github.com:Ray317/$repo.git"
	then return 1
	else return 0
	fi
}
# If pwsh not found, run through install, else, check for excel then check for repo
if ! dpkg -s powershell &> /dev/null
then
	echo "${green}Installing prereqs for PowerShell 7${reset}"
	# apt update
	if ! sudo apt-get update &> /dev/null
	then
		echo "${red}Failed to update available packages${reset}"
		exit 1
	fi
	# apt install
	if ! install_packages
	then
		echo "${red}Failed to install prereqs${reset}"
		exit 1
	fi
	download_and_install_ps7
else
	# PS7 should be installed, check for update
	if ! check_for_pwsh_update
	then
		echo "${yellow}PS7 needs to be updated${reset}" 
		download_and_install_ps7
	fi
fi

# Check for ImportExcel
if ! check_excel
then
	if ! install_excel
	then
		echo "${red}Failed to install ImportExcel${reset}"
		exit 1
	fi
fi
# Check for SSH key
if ! check_sshpub
then
	if create_ed25519
	then
		pubkey=$(cat $keyfile.pub)
		echo "Copy and paste your public key below and add it to your GitHub profile"
		echo "${bold}${yellow}$pubkey${reset}"
		echo "Once that is done, run this script again"
		exit 0
	else
		echo "${red}Failed to create new SSH key${reset}"
		exit 1
	fi
fi
# Check for repo
if ! check_repo
then
	if ! clone_repo
	then
		echo "${red}Failed to clone AvaConfigurator repo${reset}"
		exit 1
	fi
else 
	git pull --quiet
fi 
# Navigate to repo and launch app
if check_repo
then
	# Clear terminal
	tput reset
	# Change terminal text color for title w/ -n for no new line
	echo -n "${cyan}"
	figlet -k -w "$(tput cols)" -c AvaConfigurator
	# Reset back to default also w/o new line
	echo -n "${reset}"
	# Pass distro to pwsh as env var
	distro=$(grep ID_LIKE /etc/os-release)
	# Launch app with the env variables set by batch script
	AvaConfigs="$AVACONFIGS" distro="$distro" pwsh -Command "Import-Module ./Start-AvaConfigurator.ps1;Start-AvaConfigurator '$env:AvaConfigs; $env:distro'"
else
	echo "${red}Unable to navigate to repo directory${reset}"
	exit 1
fi