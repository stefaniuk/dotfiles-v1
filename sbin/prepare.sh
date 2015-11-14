#!/bin/bash

print_h1 "Preparing..."

################################################################################

if [ $DIST == "ubuntu" ]; then

    print_h2 "Fix sudo settings"
    sudo file_remove_str "Defaults[[:space:]]+env_reset" /etc/sudoers
    sudo file_remove_str "Defaults[[:space:]]+secure_path=\".*\"" /etc/sudoers

elif [ $DIST == "scientific" ]; then

    print_h2 "Fix sudo settings"
    sudo file_remove_str "Defaults[[:space:]]+env_reset" /etc/sudoers
    sudo file_remove_str "Defaults[[:space:]]+secure_path[[:space:]]+=[[:space:]]+.*" /etc/sudoers

fi

################################################################################

exit 0
