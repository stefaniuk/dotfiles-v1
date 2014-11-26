#!/bin/bash

################################################################################
# bash                                                                         #
################################################################################

print_title "Configure bash"

# resources
cp ./.{bashrc,path,bash_prompt,bash_exports,bash_functions,bash_aliases,bash_completion} ~ 2> /dev/null
cp ./.{bashrc,bash_*}.$DIST ~ 2> /dev/null
mkdir -p ~/bin
cp ./bin/* ~/bin
rm ~/bin/{install,config*}.sh
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

################################################################################
# zsh                                                                          #
################################################################################

print_title "Configure zsh"

# resources
cp ./.zshrc* ~

################################################################################
# Git                                                                          #
################################################################################

print_title "Configure Git"

# resources
cp ./config/git/.git* ~

# configuration
git config --global user.name "$USER_NAME"
git config --global user.email "$USER_EMAIL"
git config --global push.default simple

# completion
[ -f /etc/bash_completion ] && bcpath=/etc || bcpath=/usr/local/etc
if [ -d $bcpath/bash_completion.d ] && [ ! -f $bcpath/bash_completion.d/git-completion.bash ]; then
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O $bcpath/bash_completion.d/git-completion.bash
fi
unset bcpath

################################################################################
# Vim                                                                          #
################################################################################

if [ -n "$(which vim)" ]; then

    print_title "Configure Vim"

    # resources
    mkdir -p ~/.vim
    cp -Rf ./config/vim/{autoload,colors,plugin} ~/.vim
    cp -f ./config/vim/.vimrc ~

    # plug-ins
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

    # resources
    mkdir -p ~/.config/mc
    cp -f ./config/mc/* ~/.config/mc

fi

################################################################################
# Maven                                                                        #
################################################################################

if [ -n "$(which mvn)" ]; then

    print_title "Configure Maven"

    # resources
    mkdir -p ~/.m2
    cp -f ./config/maven/settings*.xml ~/.m2

fi

################################################################################

exit 0
