#!/bin/bash
set -eux

# Install i3 window manager and dependencies
sudo apt install -y i3
sudo apt install -y compton
sudo apt install -y nm-tray
sudo apt install -y light

# Install i3blocks for better status bar with graphical CPU monitoring
sudo apt install -y i3blocks

# Create config directories
mkdir -p ~/.config/i3blocks/scripts
mkdir -p ~/.config/i3

# Function to safely copy config files
copy_config() {
    local src="$1"
    local dest="$2"
    
    if [ -f "$dest" ]; then
        read -p "File $dest exists. Overwrite? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cp "$src" "$dest"
            echo "✓ Copied $src -> $dest"
        else
            echo "⊘ Skipped $dest"
        fi
    else
        cp "$src" "$dest"
        echo "✓ Copied $src -> $dest"
    fi
}

# Copy configuration files (with prompts if they exist)
copy_config "i3blocks_config" ~/.config/i3blocks/config
copy_config "i3blocks_cpu_usage_script.sh" ~/.config/i3blocks/scripts/i3blocks_cpu_usage_script.sh
copy_config "i3blocks_network_script.sh" ~/.config/i3blocks/scripts/i3blocks_network_script.sh
copy_config "i3_config" ~/.config/i3/config

# Make scripts executable
chmod +x ~/.config/i3blocks/scripts/*.sh 2>/dev/null || true

echo ""
echo "✓ i3 and i3blocks installed successfully!"
echo "✓ Configuration files copied to ~/.config/"
echo ""
echo "To use i3blocks, make sure i3_config has:"
echo "  status_command i3blocks"
echo "in the bar {} section (already configured in i3_config)"

