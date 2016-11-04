#!/bin/bash

print_h1 "Installing..."

file=~/sbin/install-$DIST.sh
if [ -f $file ]; then
    (. $file $*)
fi
unset file
