#!/bin/bash
# This script will search for a running ssh-agent instance and connect to it
# If not, will start a new instance

echo "Searching running processes for ssh-agent"
# If pgrep returns an ssh-agent process for $USER
if pgrep -u $USER ssh-agent; then
	echo "ssh-agent process found"
fi