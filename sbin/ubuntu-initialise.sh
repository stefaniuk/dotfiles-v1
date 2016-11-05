#!/bin/bash

if [ -f /etc/sudoers ]; then
    print_h2 "Sudo"
    sudo ~/bin/file_remove_str "Defaults[[:space:]]+env_reset" /etc/sudoers
    sudo ~/bin/file_remove_str "Defaults[[:space:]]+secure_path=\".*\"" /etc/sudoers
fi
