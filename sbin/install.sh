#!/bin/bash

print_h1 "Installing..."

################################################################################
# install distribution specific tools

file=~/sbin/install-$DIST.sh
if [ -f $file ]; then
    (. $file $*)
fi
unset file

################################################################################

exit 0
