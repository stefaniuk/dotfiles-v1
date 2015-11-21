#!/bin/bash

yum_install="sudo yum --assumeyes install"

################################################################################

print_h2 "Fix sudo"
sudo ~/bin/file_remove_str "Defaults[[:space:]]+env_reset" /etc/sudoers
sudo ~/bin/file_remove_str "Defaults[[:space:]]+secure_path[[:space:]]+=[[:space:]]+.*" /etc/sudoers

print_h2 "Set locale"
sudo localedef -c -i en_GB -f UTF-8 en_GB.UTF-8

print_h2 "Set timezone"
sudo ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime

print_h2 "Install certificates"
$yum_install ca-certificates

################################################################################

sudo yum clean packages

exit 0
