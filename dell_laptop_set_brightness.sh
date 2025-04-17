#!/bin/bash

set -eouxf pipefail

if [ $# -eq 0 ]
  then
    echo "Error: specify brightness as integer"
  else
    echo "Setting brightness to $1"
    echo $1 | sudo tee /sys/class/backlight/intel_backlight/brightness
fi
