#!/bin/bash

yum_install="sudo yum --assumeyes install"

################################################################################

if [ -n "$arg_install_system_tools" ]; then
    print_h2 "Install system tools"
    #$yum_install
fi

print_h2 "Install dotfiles tools"
$yum_install \

if [ -n "$arg_install_common_tools" ]; then
    print_h2 "Install common tools"
    $yum_install \
fi

if [ -n "$arg_install_server_tools" ]; then
    print_h2 "Install server tools"
    $yum_install \
fi

if [ -n "$arg_install_workstation_tools" ]; then
    print_h2 "Install workstation tools"
    $yum_install \
fi

################################################################################

sudo yum clean packages

exit 0
