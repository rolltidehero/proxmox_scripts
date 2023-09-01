#!/usr/bin/env bash

# Copyright (c) 2023 rolltidehero
# Author: rolltidehero
# License: MIT 

# Source helper functions
source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"

# Initialize script
color
catch_errors
setting_up_container
update_os

# Installing Dependencies
msg_info "Installing Dependencies"
$STD apt-get install -y curl
$STD apt-get install -y sudo
$STD apt-get install -y mc
msg_ok "Installed Dependencies"

# Set container name
msg_info "Setting container name"
read -p "Enter container name: " CONTAINER_NAME

# Install ntfy
msg_info "Installing ntfy in ${CONTAINER_NAME}"
pct enter ${CONTAINER_NAME}

# Add ntfy package repository
sudo mkdir -p /etc/apt/keyrings 
curl -fsSL https://archive.heckel.io/apt/pubkey.txt | sudo gpg --dearmor -o /etc/apt/keyrings/archive.heckel.io.gpg
sudo apt install apt-transport-https 
sudo sh -c "echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/archive.heckel.io.gpg] https://archive.heckel.io/apt debian main' > /etc/apt/sources.list.d/archive.heckel.io.list"

# Update repositories and install ntfy
sudo apt update
sudo apt install ntfy

# Enable and start ntfy service 
sudo systemctl enable ntfy
sudo systemctl start ntfy

pct exit
msg_ok "ntfy installed"

# Configure ntfy
msg_info "Configuring ntfy"

# ntfy configuration steps...

msg_ok "ntfy configured" 

# Complete
msg_info "Installation complete!"
