#!/bin/bash

print_h1 "Initialising..."

(
    [ -f $DIR/sbin/$DIST-common.sh ] && . $DIR/sbin/$DIST-common.sh $*
    [ -f $DIR/sbin/$DIST-initialise.sh ] && . $DIR/sbin/$DIST-initialise.sh $*
)
