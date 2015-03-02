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

    function load_shell_project {

        local name=$1

        if [ -f ~/projects/shell-$name/installer.sh ] && \
                [ -z "$arg_force_shell_depend_instal" ]; then
            ~/projects/shell-$name/installer.sh --do-not-run-tests

        elif [ -f ~/.shell-$name/installer.sh ] && \
                [ -z "$arg_force_shell_depend_instal" ]; then
            chmod +x ~/.shell-$name/installer.sh
            ~/.shell-$name/installer.sh --do-not-run-tests

        elif [ -f /usr/local/shell-$name/installer.sh ] && \
                [ -z "$arg_force_shell_depend_instal" ]; then
            chmod +x /usr/local/shell-$name/installer.sh
            /usr/local/shell-$name/installer.sh --do-not-run-tests

        else
            wget https://raw.githubusercontent.com/stefaniuk/shell-$name/master/installer.sh -O - | \
                /bin/bash -s -- --do-not-run-tests
        fi

        source ~/.shell-$name/shell-$name.sh 2> /dev/null
        [ $? != 0 ] && source /usr/local/shell-$name/shell-$name.sh 2> /dev/null
    }

    load_shell_project "commons"
    load_shell_project "utils"
    load_shell_project "packages"
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
    if [ "$DIST" != "macosx" ] && [ "$DIST" != "ubuntu" ] && [ "$DIST" != "scientific" ]; then
        print_err "Operating system not fully supported"
    fi

    # run install
    [ -z "$arg_config_only" ] && (. ~/sbin/install.sh $*)
    # run config
    [ -z "$arg_install_only" ] && (. ~/sbin/config.sh $*)
}

################################################################################
# main

# variables
arg_force_shell_depend_instal=$(echo "$*" | grep -o -- "--force-shell-dependencies-installation")
arg_synchronise_only=$(echo "$*" | grep -o -- "--synchronise-only")
arg_install_only=$(echo "$*" | grep -o -- "--install-only")
arg_config_only=$(echo "$*" | grep -o -- "--config-only")
arg_update_system=$(echo "$*" | grep -o -- "--update-system")
arg_update_packages=$(echo "$*" | grep -o -- "--update-packages")
arg_install_build_dependencies=$(echo "$*" | grep -o -- "--install-build-dependencies")
arg_clone_dev_repos=$(echo "$*" | grep -o -- "--clone-development-repositories")

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
