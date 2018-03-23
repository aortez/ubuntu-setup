#!/bin/bash
# script to bump the number of max file watches
# stuff like nodemon likes bigger numbers
set -eou pipefail

SYSCTL_CONF=/etc/sysctl.conf
NUM_WATCHES=65536
GUARD_STRING="set_max_user_watches"

if grep --quiet $GUARD_STRING$ $SYSCTL_CONF; then
  echo "it is already set"
else
  echo "setting max_user_watches to $NUM_WATCHES"
	echo "fs.inotify.max_user_watches=$NUM_WATCHES #$GUARD_STRING" | sudo tee -a $SYSCTL_CONF && sudo sysctl -p
	echo "have a nice day"
fi

RESULTING_NUM_WATCHES=`cat /proc/sys/fs/inotify/max_user_watches`
echo "Num watches are now: $RESULTING_NUM_WATCHES"
