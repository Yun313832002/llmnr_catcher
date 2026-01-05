#!/bin/bash

# --- Configuration ---
TOOLS_DIR="$HOME/tools"
RESPONDER_DIR="$TOOLS_DIR/Responder"
VENV_NAME="dc05"

echo "[*] Starting environment deployment..."

# 1. Create tools directory
mkdir -p "$TOOLS_DIR"
cd "$TOOLS_DIR" || { echo "[-] Failed to enter $TOOLS_DIR"; exit 1; }

# 2. Download Responder if not already present
if [ ! -d "Responder" ]; then
    echo "[*] Cloning Responder from GitHub..."
    git clone https://github.com/lgandx/Responder.git
fi

cd "$RESPONDER_DIR" || { echo "[-] Failed to enter $RESPONDER_DIR"; exit 1; }

# 3. Create Python virtual environment
echo "[*] Creating virtual environment: $VENV_NAME..."
python3 -m venv "$VENV_NAME"

# 4. Activate environment and install dependencies
# Note: Using 'source' to ensure pip runs within the venv
source "$VENV_NAME/bin/activate"

echo "[*] Upgrading pip and installing Python dependencies..."
pip install --upgrade pip
pip install aioquic netifaces

# Exit virtual environment
deactivate

# 5. Install Hashcat via system package manager
echo "[*] Updating system and installing Hashcat..."
sudo apt update && sudo apt install -y hashcat

echo "--------------------------------------------------"
echo "[+] Environment setup complete!"
echo "[+] Virtual Env Path: $RESPONDER_DIR/$VENV_NAME"
echo "[+] Usage: 'source $RESPONDER_DIR/$VENV_NAME/bin/activate' to start."
echo "--------------------------------------------------"
