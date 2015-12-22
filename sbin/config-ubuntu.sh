#!/bin/bash

################################################################################
# Sublime Text

if should_config "subl"; then

    print_h2 "Configure Sublime Text"

    # configuration
    dir=~/.config/sublime-text-3
    cp -f ~/etc/sublime/ubuntu/* $dir/Packages/User

fi

################################################################################

exit 0
