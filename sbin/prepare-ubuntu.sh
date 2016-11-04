#!/bin/bash

. $DIR/sbin/common-ubuntu.sh

print_h2 "Fix sudo"
sudo ~/bin/file_remove_str "Defaults[[:space:]]+env_reset" /etc/sudoers
sudo ~/bin/file_remove_str "Defaults[[:space:]]+secure_path=\".*\"" /etc/sudoers

print_h2 "Set locale"
$apt_get_install locales
sudo locale-gen en_GB.UTF-8

print_h2 "Set timezone"
echo "Europe/London" | sudo tee /etc/timezone
sudo dpkg-reconfigure -f noninteractive tzdata
