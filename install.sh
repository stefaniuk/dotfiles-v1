#!/bin/bash

cd $(dirname $BASH_SOURCE)

################################################################################
# variables                                                                    #
################################################################################

USER_NAME="Daniel Stefaniuk"
USER_EMAIL="daniel.stefaniuk@gmail.com"

################################################################################
# functions                                                                    #
################################################################################

function print_title() {
    tput bold
    echo "$1"
    tput sgr 0
}

function print_info() {
    tput setaf 3
    echo "    $1"
    tput sgr 0
}

function print_error() {
    tput setaf 1
    echo "$1"
    tput sgr 0
}

function install_mintleaf() {

    [ -z "$MINTLEAF_HOME" ] && MINTLEAF_HOME=/usr/local/mintleaf
    if [ ! -f $MINTLEAF_HOME/bin/bootstrap ]; then
        wget https://raw.githubusercontent.com/stefaniuk/mintleaf/master/src/bin/install.sh -O - | /bin/bash -s -- \
            --mintleaf
    fi
    if [ -f $MINTLEAF_HOME/bin/bootstrap ]; then
        source $MINTLEAF_HOME/bin/bootstrap
    else
        print_error "Unable to install MintLeaf"
        exit 3
    fi
}

################################################################################
# main                                                                         #
################################################################################

wget --quiet --timeout=10 --tries=3 --spider https://google.com
if [[ $? -ne 0 ]]; then
    print_error "No internet connection"
    exit 2
fi

# Ubuntu
if [ -f /etc/debian_version ] && [ $(cat /etc/os-release | grep "^ID=" | awk -F= '{ print $2 }') == "ubuntu" ]; then
    install_mintleaf
    (. ./config-ubuntu.sh)
# Mac OS X
elif [[ "$OSTYPE" == "darwin"* ]]; then
    install_mintleaf
    (. ./config-osx.sh)
else
    print_error "System not supported"
    exit 1
fi

exit 0
