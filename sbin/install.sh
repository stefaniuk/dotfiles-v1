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

print_h2 "Install Oh My Zsh"
if [ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
    rm -rf ~/{.oh-my-zsh,.zcompdump-*,.zlogin,.zsh*}
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
elif [ -d ~/.oh-my-zsh/.git ]; then
    (cd ~/.oh-my-zsh; git pull)
fi

if which npm > /dev/null 2>&1; then
    print_h2 "Install npm packages"
    ! npm list -g npm-check > /dev/null 2>&1 && sudo npm install -g npm-check
    ! npm list -g grunt-cli > /dev/null 2>&1 && sudo npm install -g grunt-cli
    ! npm list -g gulp > /dev/null 2>&1 && sudo npm install -g gulp
    ! npm list -g bower > /dev/null 2>&1 && sudo npm install -g bower
    ! npm list -g yo > /dev/null 2>&1 && sudo npm install -g yo
    ! npm list -g generator-generator > /dev/null 2>&1 && sudo npm install -g generator-generator
    ! npm list -g generator-jhipster > /dev/null 2>&1 && sudo npm install -g generator-jhipster
fi

################################################################################

exit 0
