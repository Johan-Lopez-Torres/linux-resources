#!/bin/bash

# INSTALL DOCKER ON DEBIAN 11

# Update system
echo "Updating system..."
sudo apt-get update -y
sudo apt-get upgrade -y

# Uninstall conflicting Docker packages if they exist
echo "Uninstalling conflicting packages..."
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
    sudo apt-get remove -y $pkg
done

# Install required dependencies
echo "Installing dependencies..."
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
echo "Adding Docker GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository
echo "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the apt package index
echo "Updating apt index..."
sudo apt-get update -y

# Install Docker Engine and required packages
echo "Installing Docker Engine and related tools..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start Docker service
echo "Starting Docker service..."
sudo systemctl start docker

# Enable Docker to start on boot
echo "Enabling Docker to start on boot..."
sudo systemctl enable docker

# Verify installation
echo "Verifying Docker installation..."
sudo docker run hello-world

# Tip for allowing non-root users to run Docker commands (optional)
echo "If you want to run Docker as a non-root user, run the following command:"
echo "sudo usermod -aG docker \$USER"
echo "Then log out and log back in for the changes to take effect."

echo "Docker installation complete!"
