#!/bin/bash

################################################################################
# resources                                                                    #
################################################################################

print_title "Copy resources"
cp ./.{bash_prompt,exports,functions,aliases} ~
cp ./.{exports.$DIST,functions.$DIST,aliases.$DIST} ~ 2> /dev/null
mkdir -p ~/bin
cp ./bin/* ~/bin
rm ~/bin/{install,config*}.sh

################################################################################
# bash                                                                         #
################################################################################

print_title "Configure bash"
cp ./.bashrc* ~
[ ! -f ~/.bash_profile ] && cp ~/.bash_profile ~/.bash_profile.old
cat << EOF > ~/.bash_profile
# BEGIN: load .bashrc
[[ -r ~/.bashrc ]] && source ~/.bashrc
# END: load .bashrc
EOF
[ -f ~/.profile ] && mv ~/.profile ~/.profile.old

################################################################################
# zsh                                                                          #
################################################################################

print_title "Configure zsh"
cp ./.zshrc* ~

################################################################################
# Git                                                                          #
################################################################################

print_title "Configure Git"
cp ./config/git/.git* ~
git config --global user.name "$USER_NAME"
git config --global user.email "$USER_EMAIL"
git config --global push.default simple

################################################################################
# Vim                                                                          #
################################################################################

if [ -n "$(which vim)" ]; then
    print_title "Configure Vim"
    mkdir -p ~/.vim
    cp -Rf ./config/vim/{autoload,colors,plugin} ~/.vim
    cp -f ./config/vim/.vimrc ~
    if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
        git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim > /dev/null 2>&1
    else
        (cd ~/.vim/bundle/Vundle.vim; git pull) > /dev/null 2>&1
    fi
fi

################################################################################
# Midnight Commander                                                           #
################################################################################

if [ -n "$(which mc)" ]; then
    print_title "Configure Midnight Commander"
    mkdir -p ~/.config/mc
    cp -f ./config/mc/* ~/.config/mc
fi

################################################################################
# Maven                                                                        #
################################################################################

if [ -n "$(which mvn)" ]; then
    print_title "Configure Maven"
    mkdir -p ~/.m2
    cp -f ./config/maven/settings*.xml ~/.m2
fi

################################################################################

exit 0
