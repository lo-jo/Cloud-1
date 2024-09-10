#!/bin/bash

# Check if $HOME/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo "Adding $HOME/.local/bin to PATH ..."
    export PATH="$PATH:$HOME/.local/bin"
fi

# Check if Ansible is already installed
if command -v ansible >/dev/null 2>&1; then
    echo "Ansible is already installed."
else
    echo "Installing Ansible via pip ..."
    pip install ansible
    # pip install boto3 botocore
    
    # Check if the pip install succeeded
    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to install Ansible."
        exit 1
    fi
fi

# Verify Ansible installation
echo "Checking Ansible version:"
ansible --version
echo "Ansible is located at: $(which ansible)"

ansible-galaxy collection install amazon.aws
