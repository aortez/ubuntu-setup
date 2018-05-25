#!/bin/bash
# WARNING - this will overwrite your existing rc.local!!!
echo "adding rc local with command to disable usb3 wakeup"
cat > /etc/rc.local << EOF
#!/bin/bash
echo "XHC" > /proc/acpi/wakeup
EOF

chmod +x /etc/rc.local
