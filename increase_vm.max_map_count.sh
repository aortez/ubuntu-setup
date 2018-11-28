#!/bin/bash
set -eou pipefail
echo "increasing the number of max number of mmap counts"
echo "stuff like Elasticsearch likes bigger numbers"

SYSCTL_CONF=/etc/sysctl.conf
NUM_MAPS=262144
GUARD_STRING="set_vm_max_map_count"

if grep --quiet $GUARD_STRING$ $SYSCTL_CONF; then
  echo "it is already set"
else
  echo "setting max_user_watches to $NUM_MAPS"
  echo "vm.max_map_count=$NUM_MAPS #$GUARD_STRING" | sudo tee -a $SYSCTL_CONF && sudo sysctl -p
  echo "have a nice day"
fi

RESULTING_NUM_MAPS=`cat /proc/sys/vm/max_map_count`
echo "vm.max_map_count is now: $RESULTING_NUM_MAPS"
