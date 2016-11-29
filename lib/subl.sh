#!/bin/bash

print_h2 "Sublime Text"

if [ $DIST = "macosx" ]; then

    $cask_install \
        sublime-text3

elif [ $DIST = "ubuntu" ]; then

    $apt_add_repository ppa:webupd8team/sublime-text-3
    $apt_get_update
    $apt_get_install \
        sublime-text-installer

fi
