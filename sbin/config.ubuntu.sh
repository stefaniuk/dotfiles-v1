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

exit 0
