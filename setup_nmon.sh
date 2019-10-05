#!/bin/bash
#
# Adds a nice alias for nmon to bashrc. Tweak that alias to meet your desires.
#
set -eou pipefail

GUARD_STRING="NMON ALIAS"

NMON_ALIAS='NMON=clmd nmon -s 1'

if grep --quiet -e "$GUARD_STRING" ~/.bashrc; then
  echo "it is already set"
else
  echo "adding nmon alias"
  echo "alias nmon=\"$NMON_ALIAS\" #$GUARD_STRING" > ~/.bashrc
  echo "have a nice day"
fi
