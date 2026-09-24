#!/bin/bash

# Requires: Run as sudo
# Usage: sudo ./install.sh

set -e

echo "================================="
echo " Ubuntu Workstation Setup"
echo "================================="
echo ""

# Check sudo
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit 1
fi


echo "Updating package list..."
apt update


echo ""
echo "Installing base dependencies..."

apt install -y \
    curl \
    wget \
    git \
    unzip \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg


# ===============================
# Browser
# ===============================

echo ""
echo "Installing Google Chrome..."

wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

apt install -y ./google-chrome-stable_current_amd64.deb

rm google-chrome-stable_current_amd64.deb


# ===============================
# Development
# ===============================

echo ""
echo "Installing Git..."

apt install -y git


echo ""
echo "Installing Python..."

apt install -y \
    python3 \
    python3-pip \
    python3-venv


echo ""
echo "Installing OpenJDK..."

apt install -y openjdk-21-jdk


echo ""
echo "Installing VS Code..."

wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor \
    > /usr/share/keyrings/microsoft.gpg


echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
    > /etc/apt/sources.list.d/vscode.list


apt update

apt install -y code


# ===============================
# Docker
# ===============================

echo ""
echo "Installing Docker..."

curl -fsSL https://get.docker.com | sh


systemctl enable docker
systemctl start docker


# Add current user to docker group
if [ -n "$SUDO_USER" ]; then
    usermod -aG docker "$SUDO_USER"
fi


# ===============================
# Utilities
# ===============================

echo ""
echo "Installing utilities..."

apt install -y \
    p7zip-full


echo ""
echo "================================="
echo " Installation Finished"
echo "================================="

echo ""
echo "Please reboot your machine."
echo "Docker group changes require logout/login."
