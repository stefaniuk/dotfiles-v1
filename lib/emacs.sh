#!/bin/bash

print_h2 "Emacs"

if [ $DIST = "ubuntu" ]; then
    $apt_get_install \
        emacs
fi
