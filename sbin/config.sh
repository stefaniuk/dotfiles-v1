#!/bin/bash

print_h1 "Configuring components..."

################################################################################
# Bash

if which bash > /dev/null 2>&1; then

    print_h2 "Configure Bash"

    # resources
    cp -f ~/etc/bash/.bash* ~
    file_replace_str "USER_NAME=\"unknown\"" "USER_NAME=\"$USER_NAME\"" ~/.bash_exports
    file_replace_str "USER_EMAIL=\"unknown\"" "USER_EMAIL=\"$USER_EMAIL\"" ~/.bash_exports

    # profile
    [ -f ~/.profile ] && [ ! -f ~/.profile.old ] && mv ~/.profile ~/.profile.old
    [ -f ~/.bash_profile ] && [ ! -f ~/.bash_profile.old ] && mv ~/.bash_profile ~/.bash_profile.old
    cat << EOF > ~/.bash_profile
# BEGIN: load .bashrc
[[ -r ~/.bashrc ]] && source ~/.bashrc
# END: load .bashrc
EOF

fi

################################################################################
# Zsh

if which zsh > /dev/null 2>&1; then

    print_h2 "Configure Zsh"

    # resources
    cp -f ~/etc/zsh/.zsh* ~

fi

################################################################################
# Git

if which git > /dev/null 2>&1; then

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
    [ -f /etc/bash_completion ] && bcpath=/etc/bash_completion.d || bcpath=/usr/local/etc/bash_completion.d
    if [ -d $bcpath ] && [ ! -f $bcpath/git-completion.bash ]; then
        sudo wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O $bcpath/git-completion.bash
    fi
    unset bcpath

fi

################################################################################
# Vim

if which vim > /dev/null 2>&1; then

    print_h2 "Configure Vim"

    # resources
    mkdir -p ~/.vim
    cp -Rf ~/etc/vim/{colors,plugin} ~/.vim
    cp -f ~/etc/vim/.vimrc ~
    mkdir -p ~/.vim/{autoload,bundle}

    # vundle
    if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
        git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    else
        (cd ~/.vim/bundle/Vundle.vim; git pull)
    fi
    # pathogen
    curl -LSso ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

    # solarized
    if [ ! -d ~/.vim/bundle/vim-colors-solarized ]; then
        git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
    else
        (cd ~/.vim/bundle/vim-colors-solarized; git pull)
    fi
    # nerdtree
    if [ ! -d ~/.vim/bundle/nerdtree ]; then
        git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
    else
        (cd ~/.vim/bundle/nerdtree; git pull)
    fi

fi

################################################################################
# Midnight Commander

if which mc > /dev/null 2>&1; then

    print_h2 "Configure Midnight Commander"

    # resources
    mkdir -p ~/.config/mc
    cp -f ~/etc/mc/* ~/.config/mc

fi

################################################################################
# Maven

if which mvn > /dev/null 2>&1; then

    print_h2 "Configure Maven"

    # resources
    mkdir -p ~/.m2
    cp -f ~/etc/maven/settings*.xml ~/.m2

fi

################################################################################
# Irssi

if which irssi > /dev/null 2>&1; then

    print_h2 "Configure Irssi"

    # resources
    mkdir -p ~/.irssi
    cp -f ~/etc/irssi/config ~/.irssi
    file_replace_str "real_name = \"\"" "real_name = \"$USER_NAME\"" ~/.irssi/config

fi

################################################################################
# configure distribution specific components

file=~/sbin/config.$DIST.sh
if [ -f $file ]; then
    print_h1 "Configuring distribution specific components..."
    (. $file $*)
fi
unset file

################################################################################

exit 0
