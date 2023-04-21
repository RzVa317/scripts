#!/bin/bash
# This script will search for a running ssh-agent instance and connect to it
# If not, will start a new instance
# Will only work when being called from .bashrc

# Set output of pgrep to $pid
pid=$(pgrep -x ssh-agent)
# If pgrep doesn't return an ssh-agent process
if [[ ! -n ${pid} ]] ; then
	# Start a new instance and save to ssh-agent.env
    ssh-agent > "${XDG_RUNTIME_DIR}/ssh-agent.env"
	# Add output to shell environment
    source "${XDG_RUNTIME_DIR}/ssh-agent.env" > /dev/null
fi
# If pgrep returned a process for ssh-agent
if [[ -n ${pid} ]] ; then
	# Add to environment
    source "${XDG_RUNTIME_DIR}/ssh-agent.env" > /dev/null
fi