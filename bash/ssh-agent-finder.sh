#!/bin/bash
# This script will search for a running ssh-agent instance and connect to it
# If not, will start a new instance

# If pgrep doesn't return an ssh-agent process for $USER
if ! pgrep -x ssh-agent > /dev/null; then
	# Start new instance and save env variables
	ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
else
	# echo "ssh-agent already running"
	source $XDG_RUNTIME_DIR/ssh-agent.env
fi