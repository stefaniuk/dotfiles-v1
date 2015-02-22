#!/bin/bash

# exit if script is sourced
[ -n "$BASH_SOURCE" ] && [ "$(basename -- "$0")" != "setup.sh" ] && exit 1

################################################################################
# variables

GITHUB_REPOSITORY_ACCOUNT="stefaniuk"
GITHUB_REPOSITORY_NAME="dotfiles"
USER_NAME=${USER_NAME-"Daniel Stefaniuk"}
USER_EMAIL=${USER_EMAIL-"daniel.stefaniuk@gmail.com"}
program_dir=$(cd "$(dirname "$0" 2> /dev/null)"; pwd)

################################################################################
# functions

function program_download {

    printf "Download $GITHUB_REPOSITORY_NAME\n\n"

    wget \
        -O ~/$GITHUB_REPOSITORY_NAME.tar.gz \
        "https://github.com/${GITHUB_REPOSITORY_ACCOUNT}/${GITHUB_REPOSITORY_NAME}/tarball/master"
    tar -zxf ~/$GITHUB_REPOSITORY_NAME.tar.gz -C ~
    rm -f ~/$GITHUB_REPOSITORY_NAME.tar.gz
    cp -rf ~/$GITHUB_REPOSITORY_ACCOUNT-$GITHUB_REPOSITORY_NAME-*/* ~
    rm -rf ~/$GITHUB_REPOSITORY_ACCOUNT-$GITHUB_REPOSITORY_NAME-*
}

function program_synchronise {

    printf "Synchronise $GITHUB_REPOSITORY_NAME\n\n"

    rsync -rav \
        --include=/ \
        --exclude=/.git* --exclude=/README.md --exclude=/LICENCE \
        $program_dir/. \
        ~

    printf "\n"
}

function program_load_dependencies {

    # shell-commons
    if [ -f ~/projects/shell-commons/installer.sh ]; then
        ~/projects/shell-commons/installer.sh --do-not-run-tests
    else
        wget https://raw.githubusercontent.com/stefaniuk/shell-commons/master/installer.sh -O - | \
            /bin/bash -s -- --do-not-run-tests
    fi
    source ~/.shell-commons/shell-commons.sh 2> /dev/null
    [ $? != 0 ] && source /usr/local/shell-commons/shell-commons.sh 2> /dev/null

    # shell-utils
    if [ -f ~/projects/shell-utils/installer.sh ]; then
        ~/projects/shell-utils/installer.sh --do-not-run-tests
    else
        wget https://raw.githubusercontent.com/stefaniuk/shell-utils/master/installer.sh -O - | \
            /bin/bash -s -- --do-not-run-tests
    fi
    source ~/.shell-utils/shell-utils.sh 2> /dev/null
    [ $? != 0 ] && source /usr/local/shell-utils/shell-utils.sh 2> /dev/null

    # shell-packages
    if [ -f ~/projects/shell-packages/installer.sh ]; then
        ~/projects/shell-packages/installer.sh --do-not-run-tests
    else
        wget https://raw.githubusercontent.com/stefaniuk/shell-packages/master/installer.sh -O - | \
            /bin/bash -s -- --do-not-run-tests
    fi
    source ~/.shell-packages/shell-packages.sh 2> /dev/null
    [ $? != 0 ] && source /usr/local/shell-packages/shell-packages.sh 2> /dev/null
}

function program_setup {

    chmod +x ~/setup.sh
    chmod +x ~/bin/*

    # variables
    arg_synchronise_only=$(echo "$*" | grep -o -- "--synchronise-only")
    arg_update_system=$(echo "$*" | grep -o -- "--update-system")
    arg_update_packages=$(echo "$*" | grep -o -- "--update-packages")
    arg_install_build_dependencies=$(echo "$*" | grep -o -- "--install-build-dependencies")
    arg_clone_dev_repos=$(echo "$*" | grep -o -- "--clone-development-repositories")

    # synchronise only
    [ -n "$arg_synchronise_only" ] && exit 0

    # check internet connection
    printf "Check internet connection\n"
    wget --quiet --timeout=10 --tries=3 --spider "https://google.com"
    if [[ $? -ne 0 ]]; then
        print_err "No internet connection"
        exit 2
    fi

    # check operating system
    printf "Check OS\n"
    if [ "$DIST" != "macosx" ] && [ "$DIST" != "ubuntu" ]; then
        print_err "Operating system not supported"
        exit 3
    fi

    # run install
    (. ~/sbin/install.sh $*)
    # run config
    (. ~/sbin/config.sh $*)
}

################################################################################
# main

if [ -z "$BASH_SOURCE" ]; then

    # download from repository
    program_download

elif [[ $program_dir == */projects/$GITHUB_REPOSITORY_NAME ]]; then

    # synchronise with project
    program_synchronise

    args="--skip-selected-tests"
fi

# make sure dependencies are installed and loaded
program_load_dependencies

# perform post-install configuration
# flags:
#       --synchronise-only
#       --update-system
#       --update-packages
#       --install-build-dependencies
#       --clone-development-repositories
program_setup $* $args

exit 0
