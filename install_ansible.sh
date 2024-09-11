#!/bin/bash

# Colors
GREEN='\e[32m'
YELLOW='\e[33m'
RED='\e[31m'
BLUE='\e[34m'
RESET='\e[0m'

# Check if $HOME/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo -e "${YELLOW}Adding $HOME/.local/bin to PATH ...${RESET}"
    export PATH="$PATH:$HOME/.local/bin"
else
    echo -e "${GREEN}$HOME/.local/bin is already in PATH.${RESET}"
fi

# Check if Ansible is already installed
if command -v ansible >/dev/null 2>&1; then
    echo -e "${GREEN}Ansible is already installed.${RESET}"
else
    echo -e "${YELLOW}Installing Ansible via pip ...${RESET}"
    pip install ansible
    # pip install boto3 botocore
    
    # Check if the pip install succeeded
    if [[ $? -ne 0 ]]; then
        echo -e "${RED}Error: Failed to install Ansible.${RESET}"
        exit 1
    fi
fi

# Verify Ansible installation
echo -e "${BLUE}Ansible version:${RESET}"
ansible --version
echo "${BLUE}Ansible is located at: $(which ansible)${RESET}"
