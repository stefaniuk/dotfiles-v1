#!/bin/bash

################################################################################
# Sublime Text

if should_config "sublime" /usr/bin/subl; then

    print_h2 "Configure Sublime Text"

    dir=~/.config/sublime-text-3

    # configuration
    mkdir -p $dir/{Installed\ Packages,Packages/User}
    #cp -f ~/etc/sublime/*.sublime-settings $dir/Packages/User

    # package control
    if [ ! -f $dir/Installed\ Packages/Package\ Control.sublime-package ]; then
        curl \
            --url http://sublime.wbond.net/Package%20Control.sublime-package \
            --output $dir/Installed\ Packages/Package\ Control.sublime-package
    fi

fi

################################################################################

exit 0
