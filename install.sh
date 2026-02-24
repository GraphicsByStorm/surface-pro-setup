#!/bin/bash
# Surface Pro 6 Complete Setup - Downloads and runs everything
# Just run this ONE command on Surface Pro:

# curl -sL https://raw.githubusercontent.com/GraphicsByStorm/surface-pro-setup/main/install.sh | bash

echo "=========================================="
echo "Surface Pro 6 Complete Setup"
echo "=========================================="
echo ""

# Download setup script
echo "[1/2] Downloading setup script..."
curl -sL https://raw.githubusercontent.com/GraphicsByStorm/surface-pro-setup/main/setup.sh -o /tmp/setup.sh

# Download reset script
echo "[2/2] Downloading reset script..."
curl -sL https://raw.githubusercontent.com/GraphicsByStorm/surface-pro-setup/main/reset.sh -o /tmp/reset.sh

# Make executable
chmod +x /tmp/setup.sh /tmp/reset.sh

# Copy to home for future use
cp /tmp/setup.sh ~/setup.sh
cp /tmp/reset.sh ~/reset.sh

echo ""
echo "Scripts downloaded!"
echo ""
echo "Run this command to START setup:"
echo "  ~/setup.sh"
echo ""
echo "After testing, run this command to prepare for sale:"
echo "  ~/reset.sh"
echo ""
