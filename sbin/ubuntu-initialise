#!/bin/bash

if [ -f /etc/sudoers ] && cat /etc/sudoers | grep "env_reset" > /dev/null || cat /etc/sudoers | grep "secure_path" > /dev/null; then
    print_h2 "Sudo"
    sudo $DIR/bin/file_remove_str "Defaults[[:space:]]+env_reset" /etc/sudoers
    sudo $DIR/bin/file_remove_str "Defaults[[:space:]]+secure_path=\".*\"" /etc/sudoers
fi
