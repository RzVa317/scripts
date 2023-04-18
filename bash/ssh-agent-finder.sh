#!/bin/bash
# This script will search for a running ssh-agent instance and connect to it
# If not, will start a new instance

echo "Checking for ssh-agent process"
# If pgrep doesn't return an ssh-agent process for $USER
# pgrep outputs the pids of processes found, so sending to the void
if ! pgrep ssh-agent; then
	# Start new instance and save env variables
	echo "Starting new instance"
	ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
else
	echo "ssh-agent already running"
fi
# At this point an ssh-agent instance should be running
# If its env variables aren't located, source them
echo "Checking for SSH_AUTH_SOCK"
if [[ ! "$SSH_AUTH_SOCK" ]]; then
	echo "Not found, sourcing ssh-agent.env"
	cat $XDG_RUNTIME_DIR/ssh-agent.env
	source $XDG_RUNTIME_DIR/ssh-agent.env
fi