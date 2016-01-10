#!/bin/bash

print_h1 "Configuring..."

################################################################################
# SSH

if should_config "ssh"; then

    print_h2 "Configure SSH"

    # resources
    mkdir -p ~/.ssh
    cp -f ~/etc/ssh/config ~/.ssh
    file_replace_str "github-user" "github-$GITHUB_ACCOUNT" ~/.ssh/config
    file_replace_str "bitbucket-user" "bitbucket-$BITBUCKET_ACCOUNT" ~/.ssh/config
    file_replace_str "gitlab-user" "gitlab-$GITLAB_ACCOUNT" ~/.ssh/config

fi

################################################################################
# Bash

if should_config "bash"; then

    print_h2 "Configure Bash"

    # profile
    [ -f ~/.profile ] && [ ! -f ~/.profile.old ] && mv ~/.profile ~/.profile.old
    [ -f ~/.bash_profile ] && [ ! -f ~/.bash_profile.old ] && mv ~/.bash_profile ~/.bash_profile.old

    # resources
    cp -f ~/etc/bash/.bash* ~
    file_replace_str "USER_NAME=\"unknown\"" "USER_NAME=\"$USER_NAME\"" ~/.bash_exports
    file_replace_str "USER_EMAIL=\"unknown\"" "USER_EMAIL=\"$USER_EMAIL\"" ~/.bash_exports
    file_replace_str "GITHUB_ACCOUNT=\"unknown\"" "GITHUB_ACCOUNT=\"$GITHUB_ACCOUNT\"" ~/.bash_exports
    file_replace_str "GITLAB_ACCOUNT=\"unknown\"" "GITLAB_ACCOUNT=\"$GITLAB_ACCOUNT\"" ~/.bash_exports

fi

################################################################################
# Zsh

if should_config "zsh"; then

    print_h2 "Configure Zsh"

    # resources
    cp -f ~/etc/zsh/.zsh* ~

    # install Oh My Zsh
    if [ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
        rm -rf ~/{.oh-my-zsh,.zcompdump-*,.zlogin,.zsh*}
        git clone \
            https://github.com/robbyrussell/oh-my-zsh.git \
            ~/.oh-my-zsh
        cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    elif [ -d ~/.oh-my-zsh/.git ]; then
        (cd ~/.oh-my-zsh; git pull)
    fi

fi

################################################################################
# Git

if should_config "git"; then

    print_h2 "Configure Git"

    # resources
    cp -f ~/etc/git/.git* ~

    # configuration
    git config --global user.name "$USER_NAME"
    git config --global user.email "$USER_EMAIL"
    if [ $(comparev $(git --version | grep -oE [0-9]+\.[0-9]+\.[0-9]+) 2.0.0) != "-1" ]; then
        git config --global push.default simple
    else
        git config --global push.default matching
    fi

    # completion
    [ -f /etc/bash_completion ] && dir=/etc/bash_completion.d || dir=/usr/local/etc/bash_completion.d
    if [ -d $dir ] && [ ! -f $dir/git-completion.bash ]; then
        sudo wget \
            https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
            -O $dir/git-completion.bash
    fi
    unset dir

fi

################################################################################
# Docker

if should_config "docker"; then

    print_h2 "Configure Docker"

    # completion
    [ -f /etc/bash_completion ] && dir=/etc/bash_completion.d || dir=/usr/local/etc/bash_completion.d
    if [ -d $dir ] && [ ! -f $dir/docker-completion.bash ]; then
        sudo wget \
            https://raw.githubusercontent.com/docker/docker/master/contrib/completion/bash/docker \
            -O $dir/docker-completion.bash
    fi
    if [ -d $dir ] && [ ! -f $dir/docker-compose-completion.bash ]; then
        sudo wget \
            https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose \
            -O $dir/docker-compose-completion.bash
    fi
    unset dir

fi

################################################################################
# Vagrant

if should_config "vagrant"; then

    print_h2 "Configure Vagrant"

    # completion
    [ -f /etc/bash_completion ] && dir=/etc/bash_completion.d || dir=/usr/local/etc/bash_completion.d
    if [ -d $dir ] && [ ! -f $dir/vagrant-completion.bash ]; then
        sudo wget \
            https://raw.github.com/kura/vagrant-bash-completion/master/etc/bash_completion.d/vagrant \
            -O $dir/vagrant-completion.bash
    fi
    unset dir

fi

################################################################################
# Vim

if should_config "vim"; then

    print_h2 "Configure Vim"

    # resources
    cp -f ~/etc/vim/.vimrc ~
    mkdir -p ~/.vim/{autoload,bundle}
    #cp -Rf ~/etc/vim/plugin ~/.vim

    # vundle - plugin manager
    if [ ! -d ~/.vim/bundle/vundle ]; then
        git clone \
            https://github.com/gmarik/Vundle.vim.git \
            ~/.vim/bundle/vundle
    else
        (cd ~/.vim/bundle/vundle; git pull)
    fi
    # pathogen - plugin manager
    wget \
        https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim \
        -O ~/.vim/autoload/pathogen.vim

    # solarized
    if [ ! -d ~/.vim/bundle/solarized ]; then
        git clone \
            https://github.com/altercation/vim-colors-solarized.git \
            ~/.vim/bundle/solarized
    else
        (cd ~/.vim/bundle/solarized; git pull)
    fi
    # nerdtree
    #if [ ! -d ~/.vim/bundle/nerdtree ]; then
    #    git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
    #else
    #    (cd ~/.vim/bundle/nerdtree; git pull)
    #fi

fi

################################################################################
# Midnight Commander

if should_config "mc"; then

    print_h2 "Configure Midnight Commander"

    # resources
    mkdir -p ~/.config/mc
    [ -f /etc/mc/mc.keymap ] && cp -L /etc/mc/mc.keymap ~/.config/mc
    [ -f /usr/local/etc/mc/mc.keymap ] && cp -L /usr/local/etc/mc/mc.keymap ~/.config/mc
    [ -f /etc/mc/mc.menu ] && cp -L /etc/mc/mc.menu ~/.config/mc/menu
    [ -f /usr/local/etc/mc/mc.menu ] && cp -L /usr/local/etc/mc/mc.menu ~/.config/mc/menu
    cp -f ~/etc/mc/* ~/.config/mc

fi

################################################################################
# Tmux

if should_config "tmux"; then

    print_h2 "Configure Tmux"

    # resources
    cp -f ~/etc/tmux/.tmux.conf ~

fi

################################################################################
# Sublime Text

if should_config "subl"; then

    print_h2 "Configure Sublime Text"

    [ "$DIST" == "macosx" ] && dir=~/Library/Application\ Support/Sublime\ Text\ 3
    [ "$DIST" == "ubuntu" ] && dir=~/.config/sublime-text-3

    if [ -n "$dir" ]; then
        # install package control
        mkdir -p "$dir/Installed Packages"
        mkdir -p "$dir/Packages/User"
        pkg_name="Package Control.sublime-package"
        pkg_dir="$dir/Installed Packages"
        if [ ! -f "$pkg_dir/$pkg_name" ]; then
            rm -rf "$dir/Packages/User/Package Control*"
            curl -L \
                --url "http://sublime.wbond.net/$pkg_name" \
                --output "$pkg_dir/$pkg_name"
        fi
        # configuration
        cp -f ~/etc/subl/*.sublime-settings "$dir/Packages/User"
    fi
fi

################################################################################
# Lynx

if should_config "lynx"; then

    print_h2 "Configure Lynx"

    # resources
    cp -f ~/etc/lynx/.lynx* ~

fi

################################################################################
# Irssi

if should_config "irssi"; then

    print_h2 "Configure Irssi"

    # resources
    mkdir -p ~/.irssi
    cp -f ~/etc/irssi/config ~/.irssi
    file_replace_str "real_name = \"\"" "real_name = \"$USER_NAME\"" ~/.irssi/config

fi

################################################################################
# Maven

if should_config "mvn"; then

    print_h2 "Configure Maven"

    # resources
    mkdir -p ~/.m2
    cp -f ~/etc/maven/settings*.xml ~/.m2

fi

################################################################################
# config

file=~/sbin/config-$DIST.sh
if [ -f $file ]; then
    (. $file $*)
fi
unset file

################################################################################

exit 0
