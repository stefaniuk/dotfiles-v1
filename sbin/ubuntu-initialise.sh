#!/bin/bash

if [ -f /etc/sudoers ]; then
    print_h2 "Sudo"
    sudo $DIR/bin/file_remove_str "Defaults[[:space:]]+env_reset" /etc/sudoers
    sudo $DIR/bin/file_remove_str "Defaults[[:space:]]+secure_path=\".*\"" /etc/sudoers
fi
