#!/bin/bash

# Surface Pro 6 OEM Reset Script
# Run this after testing to prepare for end user

echo "=========================================="
echo "Surface Pro 6 OEM Reset"
echo "=========================================="

echo "[1/3] Cleaning temporary files..."
sudo rm -rf /tmp/* 2>/dev/null || true
sudo rm -rf /var/tmp/* 2>/dev/null || true
rm -rf ~/.cache/* 2>/dev/null || true
rm -rf ~/.local/share/Trash/* 2>/dev/null || true
history -c 2>/dev/null || true

echo "[2/3] Preparing OEM account..."
sudo apt install -y oem-config-gtk 2>/dev/null || true
sudo rm -rf /home/oem/* /home/oem/.* 2>/dev/null || true
sudo touch /var/lib/oem-config/needs-config 2>/dev/null || true

echo "[3/3] Running oem-config-prepare..."
echo ""
echo "System will shutdown. Be ready to power off!"
echo ""
sleep 3
sudo oem-config-prepare || sudo shutdown -h now

echo ""
echo "DONE!"
