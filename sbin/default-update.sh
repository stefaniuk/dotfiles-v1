#!/bin/bash

print_h1 "Updating..."

(
    [ -f $DIR/sbin/$DIST-common.sh ] && . $DIR/sbin/$DIST-common.sh $*
    [ -f $DIR/sbin/$DIST-update.sh ] && . $DIR/sbin/$DIST-update.sh $*
)
