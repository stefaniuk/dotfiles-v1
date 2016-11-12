#!/bin/bash

################################################################################
# Locale

if should_config "locale" "locale-gen"; then

    print_h2 "Locale"

    sudo locale-gen en_GB.UTF-8

fi

################################################################################
# Timezone


if should_config "timezone" "dpkg-reconfigure"; then

    print_h2 "Timezone"

    echo "Europe/London" | sudo tee /etc/timezone
    sudo dpkg-reconfigure -f noninteractive tzdata

fi

################################################################################
# Sublime Text

if should_config "subl"; then

    print_h2 "Sublime Text"

    cp -f $DIR/etc/subl/ubuntu/* $DIR/.config/sublime-text-3/Packages/User

fi
