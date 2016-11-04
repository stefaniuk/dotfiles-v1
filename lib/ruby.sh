#!/bin/bash

if [ $DIST = "ubuntu" ]; then
    $apt_get_install ruby-full
    sudo gem install jekyll
fi

exit 0
