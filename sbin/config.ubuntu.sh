#!/bin/bash

################################################################################
# locale

print_h2 "Configure locale"
sudo locale-gen en_GB.UTF-8
sudo dpkg-reconfigure locales

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
    #apm install compare-files
    apm install git-history
    apm install git-log
    apm install git-plus
    apm install language-ini
    apm install open-last-project
    apm install open-recent
    apm install sort-lines

fi

################################################################################

exit 0
