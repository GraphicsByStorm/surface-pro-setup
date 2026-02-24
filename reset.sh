#!/bin/bash

# Surface Pro 6 OEM Reset Script
# Run after testing to prepare for end user

echo "=========================================="
echo "Surface Pro 6 OEM Reset"
echo "=========================================="

echo "[1/4] Cleaning temporary files..."
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
rm -rf ~/.cache/* 2>/dev/null || true
rm -rf ~/.local/share/Trash/* 2>/dev/null || true
history -c
cat /dev/null > ~/.bash_history 2>/dev/null || true

echo "[2/4] Cleaning bash history..."
history -c

echo "[3/4] Preparing OEM account..."
sudo apt install -y oem-config-gtk 2>/dev/null || true
sudo rm -rf /home/oem/* /home/oem/.* 2>/dev/null || true
sudo touch /var/lib/oem-config/needs-config 2>/dev/null || true

echo "[4/4] Running oem-config-prepare..."
echo ""
read -p "Ready to shutdown for end user? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo oem-config-prepare
else
    echo "Cancelled. Run this script again when ready."
    exit 0
fi

echo ""
echo "=========================================="
echo "OEM PREPARE COMPLETE!"
echo "=========================================="
echo "System will shutdown. Do not power on before shipping."
echo ""
