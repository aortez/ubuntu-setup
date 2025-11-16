#!/bin/bash

# Script to enable core dumps on Ubuntu systems.
# This script configures both systemd-coredump and traditional core dumps.

set -e

# Color codes for output.
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color.

echo -e "${GREEN}Core Dump Enablement Script${NC}"
echo "==============================="
echo ""

# Function to check if running as root.
needs_sudo() {
    if [ "$EUID" -eq 0 ]; then
        echo ""
    else
        echo "sudo"
    fi
}

# Function to backup a file before modifying.
backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}Backing up $file to $backup${NC}"
        $(needs_sudo) cp "$file" "$backup"
    fi
}

# 1. Enable core dumps in shell configuration.
echo -e "${GREEN}Step 1: Configuring shell for unlimited core dumps${NC}"

# Add ulimit to bashrc if not already present.
if ! grep -q "ulimit -c unlimited" ~/.bashrc 2>/dev/null; then
    echo "" >> ~/.bashrc
    echo "# Enable core dumps." >> ~/.bashrc
    echo "ulimit -c unlimited" >> ~/.bashrc
    echo "Added 'ulimit -c unlimited' to ~/.bashrc"
else
    echo "'ulimit -c unlimited' already in ~/.bashrc"
fi

# Also add to profile for login shells.
if ! grep -q "ulimit -c unlimited" ~/.profile 2>/dev/null; then
    echo "" >> ~/.profile
    echo "# Enable core dumps." >> ~/.profile
    echo "ulimit -c unlimited" >> ~/.profile
    echo "Added 'ulimit -c unlimited' to ~/.profile"
else
    echo "'ulimit -c unlimited' already in ~/.profile"
fi

# 2. Configure systemd-coredump (since it's already in use).
echo -e "${GREEN}Step 2: Configuring systemd-coredump${NC}"

COREDUMP_CONF="/etc/systemd/coredump.conf.d/custom.conf"
$(needs_sudo) mkdir -p /etc/systemd/coredump.conf.d/

echo "Creating custom coredump configuration..."
$(needs_sudo) tee "$COREDUMP_CONF" > /dev/null << EOF
# Custom core dump configuration.
[Coredump]
Storage=external
Compress=yes
ProcessSizeMax=2G
ExternalSizeMax=2G
MaxUse=1G
KeepFree=1G
EOF

echo "Systemd-coredump configuration created at $COREDUMP_CONF"

# 3. Configure system-wide limits.
echo -e "${GREEN}Step 3: Configuring system-wide limits${NC}"

LIMITS_CONF="/etc/security/limits.d/core.conf"
echo "Creating core dump limits configuration..."
$(needs_sudo) tee "$LIMITS_CONF" > /dev/null << EOF
# Enable unlimited core dumps for all users.
* soft core unlimited
* hard core unlimited
root soft core unlimited
root hard core unlimited
EOF

echo "System limits configuration created at $LIMITS_CONF"

# 4. Configure sysctl for traditional core dumps (as fallback option).
echo -e "${GREEN}Step 4: Configuring sysctl settings${NC}"

# Check current core pattern.
CURRENT_PATTERN=$(cat /proc/sys/kernel/core_pattern)
echo "Current core pattern: $CURRENT_PATTERN"

# Since systemd-coredump is already configured, we'll keep it but add a sysctl config.
# for documentation purposes.
SYSCTL_CONF="/etc/sysctl.d/60-core-pattern.conf"
echo "Creating sysctl configuration for documentation..."
$(needs_sudo) tee "$SYSCTL_CONF" > /dev/null << EOF
# Core dump pattern configuration.
# Currently using systemd-coredump (recommended).
# To switch to local core files, uncomment the following line:
#kernel.core_pattern = /var/crash/core.%e.%p.%t

# For debugging, you can also use:
#kernel.core_pattern = core.%e.%p.%t
EOF

echo "Sysctl configuration created at $SYSCTL_CONF"

# 5. Create crash directory for alternative core dump location.
echo -e "${GREEN}Step 5: Creating crash directory${NC}"
$(needs_sudo) mkdir -p /var/crash
$(needs_sudo) chmod 1777 /var/crash
echo "Created /var/crash directory with appropriate permissions"

# 6. Apply settings immediately for current session.
echo -e "${GREEN}Step 6: Applying settings for current session${NC}"
ulimit -c unlimited
echo "Core dump limit set to unlimited for current session"

# Reload systemd configuration.
$(needs_sudo) systemctl daemon-reload

# 7. Verification.
echo ""
echo -e "${GREEN}=== Verification ===${NC}"
echo ""

# Check ulimit.
echo -n "Current ulimit -c: "
ulimit -c

# Check core pattern.
echo -n "Core pattern: "
cat /proc/sys/kernel/core_pattern

# Check systemd-coredump service.
echo ""
echo "Systemd-coredump status:"
systemctl is-active systemd-coredump.socket || true

echo ""
echo -e "${GREEN}=== Testing Core Dumps ===${NC}"
echo ""
echo "To test core dump generation, you can run:"
echo "  bash -c 'kill -SIGSEGV \$\$'"
echo ""
echo "To view core dumps with systemd:"
echo "  coredumpctl list           # List all core dumps"
echo "  coredumpctl info           # Show info about last core dump"
echo "  coredumpctl gdb            # Open last core dump in gdb"
echo ""
echo "Core dumps are stored in: /var/lib/systemd/coredump/"
echo ""
echo -e "${GREEN}Core dump configuration complete!${NC}"
echo ""
echo -e "${YELLOW}Note: You may need to log out and back in for all changes to take effect.${NC}"