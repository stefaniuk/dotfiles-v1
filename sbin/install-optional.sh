#!/bin/bash

print_h1 "Installing optional components..."

################################################################################
# install custom packages

print_h2 "Install components via spkg"
spkg install \
    vim -c -g \
    mc -c -g \
    -s

################################################################################

exit 0
