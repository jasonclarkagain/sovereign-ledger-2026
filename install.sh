#!/bin/bash
# Sovereign-Ledger-2026 Bootstrap Script
set -e

echo "[*] Updating System Repositories..."
sudo apt update

echo "[*] Installing Essential Build Tools..."
sudo apt install -y curl wget git build-essential gnupg2 software-properties-common

# 1. Install Node.js (Latest LTS)
echo "[*] Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# 2. Install Go (Golang)
echo "[*] Installing Go..."
sudo apt install -y golang-go

# 3. Install Terraform
echo "[*] Installing Terraform..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install -y terraform

# 4. Install & Initialize IPFS
if ! command -v ipfs &> /dev/null; then
    echo "[*] Installing IPFS..."
    wget https://dist.ipfs.io/go-ipfs/v0.12.0/go-ipfs_v0.12.0_linux-amd64.tar.gz
    tar -xvzf go-ipfs_v0.12.0_linux-amd64.tar.gz
    sudo bash go-ipfs/install.sh
    ipfs init
fi

echo "[+] Sovereign-Ledger-2026 Environment Successfully Provisioned."
