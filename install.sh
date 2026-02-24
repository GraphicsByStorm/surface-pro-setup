#!/bin/bash

# Surface Pro 6 Complete Setup Script

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
# Download GPG key with error handling
if ! wget -qO - https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/linux-surface.gpg 2>&1; then
    echo "GPG key download failed, trying alternative method..."
    # Alternative: download key file first
    wget -O /tmp/surface.asc https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc
    gpg --dearmor /tmp/surface.asc | sudo dd of=/etc/apt/trusted.gpg.d/linux-surface.gpg
fi

echo "deb [arch=amd64] https://pkg.surfacelinux.com/debian release main" | sudo tee /etc/apt/sources.list.d/linux-surface.list
sudo apt update

echo "[4/8] Installing Surface kernel..."
sudo apt install -y linux-image-surface linux-headers-surface libwacom-surface || echo "Kernel install had issues, continuing..."

echo "[5/8] Loading kernel modules..."
sudo modprobe surface_hid 2>/dev/null || true
sudo modprobe surface_hid_core 2>/dev/null || true
sudo modprobe hid_multitouch 2>/dev/null || true

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
