#!/bin/bash

print_h1 "Installing..."

(
    [ -f $DIR/sbin/$DIST-common.sh ] && . $DIR/sbin/$DIST-common.sh $*
    [ -f $DIR/sbin/$DIST-install.sh ] && . $DIR/sbin/$DIST-install.sh $*
)
