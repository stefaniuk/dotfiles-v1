#!/bin/bash

# exit if script is sourced
[ -n "$BASH_SOURCE" ] && [ "$(basename -- "$0")" != "setup.sh" ] && exit 1

################################################################################
# variables

GITHUB_REPOSITORY_ACCOUNT="stefaniuk"
GITHUB_REPOSITORY_NAME="dotfiles"
USER_NAME=${USER_NAME-$USER}
USER_EMAIL=${USER_EMAIL-$USER@$HOSTNAME}
program_dir=$(cd "$(dirname "$0" 2> /dev/null)"; pwd)
arg_help=$(echo "$*" | grep -o -- "--help")
arg_sudo=$(echo "$*" | grep -o -- "--sudo")
arg_exclude_shell_dependencies=$(echo "$*" | grep -o -- "--exclude-shell-dependencies")
arg_force_download_shell_dependencies=$(echo "$*" | grep -o -- "--force-download-shell-dependencies")
arg_synchronise_only=$(echo "$*" | grep -o -- "--synchronise-only")
arg_prepare=$(echo "$*" | grep -o -- "--prepare")
arg_install=$(echo "$*" | grep -o -- "--install")
arg_config=$(echo "$*" | grep -o -- "--config")
arg_update_system=$(echo "$*" | grep -o -- "--update-system")
arg_update_packages=$(echo "$*" | grep -o -- "--update-packages")
arg_install_build_dependencies=$(echo "$*" | grep -o -- "--install-build-dependencies")

################################################################################
# functions

function usage {

    local file=$(basename $0 2> /dev/null)

    echo "
File: ${file}

Usage:
    ${file} [options]

Options:
    --help
    --sudo
    --exclude-shell-dependencies
    --force-download-shell-dependencies
    --synchronise-only
    --prepare
    --install
    --config
    --update-system
    --update-packages
    --install-build-dependencies
"

    exit 0
}

function sudo_keep_alive {

    # update user's time stamp, prompting for password if necessary
    sudo -v
    # keep-alive until script has finished then invalidate sudo session
    while true; do
        sudo -n true
        sleep 1
        if ! kill -0 "$$"; then
            sudo -k
            exit
        fi
    done 2>/dev/null &
}

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
        $program_dir/* \
        ~

    printf "\n"
}

function program_load_dependencies {

    if [ -z "$arg_exclude_shell_dependencies" ]; then

        # project
        if [ -f ~/projects/shell-fusion/installer.sh ] && \
                [ -z "$arg_force_download_shell_dependencies" ]; then
            ~/projects/shell-fusion/installer.sh --do-not-run-tests

        # local installation
        elif [ -f ~/.shell-fusion/installer.sh ] && \
                [ -z "$arg_force_download_shell_dependencies" ]; then
            ~/.shell-fusion/installer.sh --do-not-run-tests

        # global installation
        elif [ -f /usr/local/shell-fusion/installer.sh ] && \
                [ -z "$arg_force_download_shell_dependencies" ]; then
            /usr/local/shell-fusion/installer.sh --do-not-run-tests

        # repository
        else
            wget https://raw.githubusercontent.com/stefaniuk/shell-fusion/master/installer.sh -O - | \
                /bin/bash -s -- --do-not-run-tests
        fi
    fi

    source ~/.shell-fusion/shell-fusion.sh 2> /dev/null
    [ $? != 0 ] && source /usr/local/shell-fusion/shell-fusion.sh 2> /dev/null
}

function program_setup {

    chmod +x ~/setup.sh
    chmod +x ~/bin/*

    # synchronise only
    [ -n "$arg_synchronise_only" ] && exit 0

    # check internet connection
    printf "Check internet connection\n"
    wget --quiet --timeout=10 --tries=3 --spider "https://google.com"
    if [[ $? -ne 0 ]]; then
        print_err "No internet connection"
    fi

    # check operating system
    printf "Check OS\n"
    if [ $DIST != "macosx" ] && [ $DIST != "ubuntu" ] && [ $DIST != "scientific" ]; then
        print_err "Operating system might not be fully supported"
    fi

    # prepare
    [ -n "$arg_prepare" ] && (. ~/sbin/prepare.sh $*)
    # install
    [ -n "$arg_install" ] && (. ~/sbin/install.sh $*)
    # config
    [ -n "$arg_config" ] && (. ~/sbin/config.sh $*)
}

################################################################################
# main

[ -n "$arg_help" ] && usage
[ -n "$arg_sudo" ] && sudo_keep_alive

if [ -z "$BASH_SOURCE" ]; then

    # download from repository
    program_download

elif [[ $program_dir == */projects/$GITHUB_REPOSITORY_NAME ]]; then

    # synchronise with project
    program_synchronise

fi

# make sure dependencies are installed and loaded
program_load_dependencies

# perform post-install configuration
program_setup $*

exit 0
