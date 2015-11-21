#!/bin/bash

apt_get_install="sudo apt-get --yes --ignore-missing --no-install-recommends install"
DEBIAN_FRONTEND="noninteractive"

################################################################################

print_h2 "Fix sudo"
sudo ~/bin/file_remove_str "Defaults[[:space:]]+env_reset" /etc/sudoers
sudo ~/bin/file_remove_str "Defaults[[:space:]]+secure_path=\".*\"" /etc/sudoers

print_h2 "Set locale"
$apt_get_install locales
sudo localedef -i en_GB -c -f UTF-8 -A /usr/share/locale/locale.alias en_GB.UTF-8

print_h2 "Set timezone"
echo "Europe/London" | sudo tee /etc/timezone
sudo dpkg-reconfigure -f noninteractive tzdata

print_h2 "Install certificates"
$apt_get_install ca-certificates

################################################################################

sudo apt-get --yes autoremove
sudo apt-get clean

exit 0
