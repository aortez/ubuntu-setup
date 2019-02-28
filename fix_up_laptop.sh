#!/bin/bash
echo "WARNING - this will overwrite your existing rc.local!!!"
echo "(At least it makes a backup...)"
echo "Adding rc local with command to disable usb3 wakeup"
echo "and command to set microsoft-style numpad."
echo "Run me with sudo."

cp /etc/rc.local /etc/rc.local.bak

cat > /etc/rc.local << EOF
#!/bin/bash

# Disable wake on usb3.
echo "XHC" > /proc/acpi/wakeup

# Set microsoft-style numpad (e.g. so SHIFT-END/1 highlights a row, rather than the
# default of inputting a "1".
setxkbmap -option 'numpad:microsoft'
EOF

chmod +x /etc/rc.local
