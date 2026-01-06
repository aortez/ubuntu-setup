#!/bin/bash
# Network status script for i3blocks

# Get active network interface
interface=$(ip route get 1.1.1.1 2>/dev/null | grep -Po '(?<=dev\s)\w+' | head -1)

if [ -z "$interface" ]; then
    echo "⚠ Down"
    exit 0
fi

# Check if wireless or ethernet
if [[ $interface == wl* ]]; then
    # Wireless
    ssid=$(iw dev "$interface" link | grep SSID | awk '{print $2}')
    signal=$(iw dev "$interface" link | grep signal | awk '{print $2}')
    ip=$(ip addr show "$interface" | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
    echo "W: $ssid ($signal dBm) $ip"
else
    # Ethernet
    ip=$(ip addr show "$interface" | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
    speed=$(ethtool "$interface" 2>/dev/null | grep Speed | awk '{print $2}')
    if [ -n "$speed" ]; then
        echo "E: $ip ($speed)"
    else
        echo "E: $ip"
    fi
fi
