#!/bin/bash

print_h1 "Installing..."

################################################################################
# install distribution specific tools

file=~/sbin/install.$DIST.sh
if [ -f $file ]; then
    (. $file $*)
fi
unset file

################################################################################
# install common tools

print_h2 "Install common tools"
# Oh My Zsh
if [ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
    rm -rf ~/{.oh-my-zsh,.zcompdump-*,.zlogin,.zsh*}
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
elif [ -d ~/.oh-my-zsh/.git ]; then
    (cd ~/.oh-my-zsh; git pull)
fi

################################################################################

exit 0
