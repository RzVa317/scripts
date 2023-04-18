#!/bin/bash
# This script will search for a running ssh-agent instance and connect to it
# If not, will start a new instance

echo "Searching running processes for ssh-agent"
# If pgrep doesn't return an ssh-agent process for $USER
# pgrep outputs the pids of processes found, so sending to the void
if ! pgrep -u $USER ssh-agent > /dev/null; then
	echo "No processes found for ssh-agent"
	# Start new instance
	eval `ssh-agent`
else
	echo "ssh-agent process found, will add to env"
fi
