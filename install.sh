#!/bin/bash

# Surface Pro 6 Complete Setup Script
# Single script - does everything: install kernel, set up, and OEM reset

set -e

# Check if running as root
if [ "$EUID" -eq 0 ]; then 
   echo "ERROR: Do not run with sudo. Run as: ./install.sh"
   exit 1
fi

echo "=========================================="
echo "Surface Pro 6 Ubuntu Setup"
echo "=========================================="
echo ""

echo "[1/8] Updating system..."
sudo apt update
sudo apt upgrade -y

echo "[2/8] Installing dependencies..."
sudo apt install -y wget gnupg build-essential curl

echo "[3/8] Adding Surface repository..."
wget -qO - https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/linux-surface.gpg
echo "deb [arch=amd64] https://pkg.surfacelinux.com/debian release main" | sudo tee /etc/apt/sources.list.d/linux-surface.list
sudo apt update

echo "[4/8] Installing Surface kernel..."
sudo apt install -y linux-image-surface linux-headers-surface libwacom-surface

echo "[5/8] Loading kernel modules..."
sudo modprobe surface_hid || true
sudo modprobe surface_hid_core || true
sudo modprobe hid_multitouch || true

echo "[6/8] Configuring modules to load at boot..."
echo -e "surface_hid\nsurface_hid_core\nhid_multitouch" | sudo tee /etc/modules-load.d/surface.conf

echo "[7/8] Creating OEM user account..."
sudo useradd -m -s /bin/bash oem 2>/dev/null || true
echo "oem:oem123" | sudo chpasswd
sudo usermod -aG sudo oem 2>/dev/null || true

echo "[8/8] Installing OEM tools..."
sudo apt install -y oem-config-gtk
sudo apt clean

echo ""
echo "=========================================="
echo "SETUP COMPLETE!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Run: sudo reboot"
echo "2. Test hardware (touchscreen, keyboard, trackpad)"
echo "3. Take screenshot for listing"
echo ""
echo "When ready to prepare for sale, run:"
echo "  ~/reset.sh"
echo ""
echo "Or manually run: sudo oem-config-prepare"
echo ""
