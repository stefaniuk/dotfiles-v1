#!/bin/bash

if [ -f /etc/sudoers ]; then
    print_h2 "Sudo"
    if cat /etc/sudoers | grep "env_reset"; then
        sudo $DIR/bin/file_remove_str "Defaults[[:space:]]+env_reset" /etc/sudoers
    fi
    if cat /etc/sudoers | grep "secure_path"; then
        sudo $DIR/bin/file_remove_str "Defaults[[:space:]]+secure_path=\".*\"" /etc/sudoers
    fi
fi
