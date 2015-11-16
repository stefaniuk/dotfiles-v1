#!/bin/bash

print_h1 "Installing..."

################################################################################
# install distribution specific tools

file=~/sbin/install-$DIST.sh
if [ -f $file ] && [ -z "$VIRTUALISATION" ]; then
    (. $file $*)
fi
unset file

################################################################################

exit 0
