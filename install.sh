#!/bin/bash

# update the user's cached credentials, authenticating the user if necessary
sudo -v
# keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

cd $(dirname $BASH_SOURCE)

################################################################################
# variables                                                                    #
################################################################################

[ -z "$USER_NAME" ] && USER_NAME="Daniel Stefaniuk"
[ -z "$USER_EMAIL" ] && USER_EMAIL="daniel.stefaniuk@gmail.com"

################################################################################
# functions                                                                    #
################################################################################

function print_progress() {
    tput bold
    echo "$1"
    tput sgr 0
}

function print_title() {
    tput setaf 4
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
    echo
    tput sgr 0
}

################################################################################
# main                                                                         #
################################################################################

# check operating system
print_progress "Checking OS..."
if ([ ! -f /etc/debian_version ] || [ $(cat /etc/os-release | grep "^ID=" | awk -F= '{ print $2 }') != "ubuntu" ]) && [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "Operating system not supported"
    exit 1
fi

# check internet connection
print_progress "Checking internet connection..."
wget --quiet --timeout=10 --tries=3 --spider "https://google.com"
if [[ $? -ne 0 ]]; then
    print_error "No internet connection"
    exit 2
fi

# install MintLeaf
print_progress "Installing MintLeaf..."
[ -z "$MINTLEAF_HOME" ] && MINTLEAF_HOME=/usr/local/mintleaf
if [ ! -f $MINTLEAF_HOME/bin/bootstrap ]; then
    wget https://raw.githubusercontent.com/stefaniuk/mintleaf/master/src/bin/install.sh -O - | /bin/bash -s -- \
        --mintleaf
fi
if [ -f $MINTLEAF_HOME/bin/bootstrap ]; then
    __mintleaf_loaded="no" source $MINTLEAF_HOME/bin/bootstrap
else
    print_error "Unable to install MintLeaf"
    exit 3
fi

# install and configure system components
if [ "$DIST" == "ubuntu" ]; then
    print_progress "Installing system components..."
    (. $MINTLEAF_HOME/bin/install.sh \
        --git \
        --java8)
    print_progress "Configuring system components..."
    (. ./config-ubuntu)
elif [ "$DIST" == "macosx" ]; then
    print_progress "Installing system components..."
    (. $MINTLEAF_HOME/bin/install.sh \
        --git --ruby \
        --java8 --groovy --spring-cli --maven --gradle \
        --virtualbox --vagrant --packer \
        --spring-sts)
    print_progress "Configuring system components..."
    (. ./config-macosx)
fi

################################################################################
# resources                                                                    #
################################################################################

print_progress "Copying resources..."
cp ./{.exports,.functions,.aliases} ~/
mkdir -p ~/bin/
cp ./bin/* ~/bin/
[ -f ~/.bash_profile ] && file_remove_str "\n# BEGIN: load dotfiles\n(.)*# END: load dotfiles\n" ~/.bash_profile --multiline
cat << EOF >> ~/.bash_profile

# BEGIN: load dotfiles
source ~/bin/bootstrap
# END: load dotfiles
EOF

################################################################################

exit 0
