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
        compare-files \
        git-history \
        git-log \
        git-plus \
        language-ini \
        open-last-project \
        open-recent \
        sort-lines

fi

################################################################################

exit 0
