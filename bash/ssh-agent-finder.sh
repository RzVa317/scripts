#!/bin/bash
# This script will search for $SSH_AGENT_PID
# If not found will start new instance of ssh-agent and save to env
echo "Searching for ${SSH_AGENT_PID}"
if [[ ! -n "${SSH_AGENT_PID}" ]]; then
	echo "SSH_AGENT_PID is not set, starting new instance of ssh-agent"
	eval "$(ssh-agent)"
	echo "sourced: ${SSH_AGENT_PID}"
	export SSH_AGENT_PID
	export SSH_AUTH_SOCK
else
	echo "SSH_AGENT_PID is set to ${SSH_AGENT_PID}"
fi