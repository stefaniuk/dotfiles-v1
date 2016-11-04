#!/bin/bash

print_h1 "Preparing..."

file=~/sbin/prepare-$DIST.sh
if [ -f $file ]; then
    (. $file $*)
fi
unset file
