#!/bin/bash

set -e

echo "Searching for package manager..."

if [ -f /etc/arch-release ]; then
    echo "Detected Arch Linux. Installing packages..."
    sudo pacman -S --noconfirm pyright gopls nodejs npm unzip wget curl

elif [ -f /etc/debian_version ] || [ -f /etc/lsb-release ]; then
    echo "Detected Debian/Ubuntu. Installing packages..."
    sudo apt update
    sudo apt install -y pyright gopls nodejs npm unzip wget curl

elif [ -f /etc/fedora-release ]; then
    echo "Detected Fedora. Installing packages..."
    sudo dnf check-update || true
    sudo dnf install -y pyright gopls nodejs npm unzip wget curl

else
    echo "Unsupported OS. Please install pyright, gopls, nodejs, npm, unzip, wget, and curl manually."
    exit 1
fi
echo "Preparing configuration directory..."
mkdir -p ~/.config
if [ -d "nvim" ]; then
    echo "Moving nvim configuration to ~/.config/nvim..."
    mv nvim ~/.config/
    echo "Done! Neovim configuration is set up."
else
    echo "Error: 'nvim' directory not found in the current folder."
    exit 1
fi
