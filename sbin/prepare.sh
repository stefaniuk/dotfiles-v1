#!/bin/bash

print_h1 "Preparing..."

################################################################################
# prepare

file=~/sbin/prepare-$DIST.sh
if [ -f $file ]; then
    (. $file $*)
fi
unset file

################################################################################

exit 0
