#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt-get update

# Install Ruby and build essentials (required for Asciidoctor)
echo "Installing Ruby and build essentials..."
sudo apt-get install -y ruby ruby-dev build-essential

# Install Asciidoctor
echo "Installing Asciidoctor..."
sudo gem install asciidoctor

# Install additional Asciidoctor extensions (optional but recommended)
echo "Installing Asciidoctor extensions..."
sudo gem install asciidoctor-pdf
sudo gem install asciidoctor-diagram

# Verify installation
echo "Verifying Asciidoctor installation..."
asciidoctor --version

echo "Asciidoctor installation completed!"
