#!/bin/bash

################################################################################
# constants                                                                    #
################################################################################

GITHUB_REPOSITORY_ACCOUNT="stefaniuk"
GITHUB_REPOSITORY_NAME="dotfiles"
[ -z "$USER_NAME" ] && USER_NAME="Daniel Stefaniuk"
[ -z "$USER_EMAIL" ] && USER_EMAIL="daniel.stefaniuk@gmail.com"

################################################################################
# functions                                                                    #
################################################################################

# `readlink -f` alternative
function abspath() { pushd . > /dev/null; if [ -d "$1" ]; then cd "$1"; dirs -l +0; else cd "`dirname \"$1\"`"; cur_dir=`dirs -l +0`; if [ "$cur_dir" == "/" ]; then echo "$cur_dir`basename \"$1\"`"; else echo "$cur_dir/`basename \"$1\"`"; fi; fi; popd > /dev/null; }

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
# download                                                                     #
################################################################################

cd $(dirname $(abspath $0))
if [ ! -f ./config-ubuntu ] || [ ! -f ./config-macosx ]; then

    print_progress "Downloading dotfiles..."

    dir=/tmp/dotfiles-$RANDOM

    rm -rf $dir
    mkdir -p $dir
    wget -O $dir/$GITHUB_REPOSITORY_NAME.tar.gz "https://github.com/$GITHUB_REPOSITORY_ACCOUNT/$GITHUB_REPOSITORY_NAME/tarball/master"
    tar zxf $dir/$GITHUB_REPOSITORY_NAME.tar.gz -C $dir
    cd $(ls -d -1 $dir/$GITHUB_REPOSITORY_ACCOUNT-$GITHUB_REPOSITORY_NAME-*)

    chmod +x ./install.sh
    ./install.sh $*
    result=${PIPESTATUS[0]}
    rm -rf $dir
    exit $result

fi

################################################################################
# main                                                                         #
################################################################################

# update the user's cached credentials, authenticating the user if necessary
sudo -v
# keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

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
    [ -z "$MINTLEAF_HOME" ] && (. $MINTLEAF_HOME/bin/install.sh \
        --git
    )
    print_progress "Configuring system components..."
    (. ./config-ubuntu)
elif [ "$DIST" == "macosx" ] && [ -z "$MINTLEAF_HOME" ]; then
    print_progress "Installing system components..."
    [ -z "$MINTLEAF_HOME" ] && (. $MINTLEAF_HOME/bin/install.sh \
        --git \
        --groovy \
        --java8 \
        --nodejs \
        --packer \
        --ruby \
        --spring-cli \
        --vagrant \
        --virtualbox
    )
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
