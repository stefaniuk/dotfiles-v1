#!/bin/bash

print_h1 "Updating..."

file=~/sbin/update-$DIST.sh
if [ -f $file ]; then
    (. $file $*)
fi
unset file

exit 0
