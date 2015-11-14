#!/bin/bash

print_h1 "Installing..."

################################################################################
# install distribution specific tools

if [ -z "$VIRTUALISATION" ] && [ -f ~/sbin/install-$DIST.sh ]; then
    (. ~/sbin/install-$DIST.sh $*)
elif [ "$VIRTUALISATION" == "container" ] && [ -f ~/sbin/install-container.sh ]; then
    (. ~/sbin/install-container.sh $*)
fi

################################################################################

exit 0
