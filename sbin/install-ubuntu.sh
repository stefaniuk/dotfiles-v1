#!/bin/bash

DEBIAN_FRONTEND="noninteractive"
apt_get_install="sudo apt-get --yes --ignore-missing --no-install-recommends install"

################################################################################
# update

if [ -n "$arg_update" ]; then
    print_h2 "Update"
    sudo apt-get --yes update
    sudo apt-get --yes upgrade
fi

################################################################################
# install

if [ -n "$arg_install_system_tools" ]; then
    print_h2 "Install system tools"
    $apt_get_install \
        ?
fi

print_h2 "Install dotfiles tools"
$apt_get_install \
    ?

if [ -n "$arg_install_common_tools" ]; then
    print_h2 "Install common tools"
    $apt_get_install \
        ?
fi

if [ -n "$arg_install_server_tools" ]; then
    print_h2 "Install server tools"
    $apt_get_install \
        ?
fi

if [ -n "$arg_install_workstation_tools" ]; then
    print_h2 "Install workstation tools"
    $apt_get_install \
        ?
    # compiz
    #$apt_get_install \
    #    compiz \
    #    compizconfig-settings-manager \
    #    compiz-plugins-default \
    #    compiz-plugins
    # conky
    #sudo add-apt-repository --yes ppa:teejee2008/ppa
    #sudo apt-get update
    #$apt_get_install \
    #    conky conky-manager \
    #    lm-sensors \
    #    hddtemp
fi

################################################################################
# clean up

sudo apt-get --yes autoremove
sudo apt-get clean

exit 0
