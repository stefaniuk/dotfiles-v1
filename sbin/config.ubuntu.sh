#!/bin/bash

################################################################################
# Conky

if which conky > /dev/null 2>&1; then

    print_h2 "Configure Conky"

    :

fi

################################################################################
# Atom

if which atom > /dev/null 2>&1; then

    print_h2 "Configure Atom"

    # resources
    mkdir -p ~/.atom
    cp -f ~/etc/atom/* ~/.atom

    # packages
    apm install \
        git-plus \
        git-log \
        git-history

fi

################################################################################

exit 0
