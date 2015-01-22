#!/bin/bash

# check internet connection
print_h1 "Checking internet connection..."
wget --quiet --timeout=10 --tries=3 --spider "https://google.com"
if [[ $? -ne 0 ]]; then
    print_err "No internet connection"
    exit 1
fi

# check operating system
print_h1 "Checking OS..."
if [ "$DIST" != "macosx" ] && [ "$DIST" != "ubuntu" ]; then
    print_err "Operating system not supported"
    exit 2
fi

# install components
if [ "$DIST" == "macosx" ]; then

    print_h1 "Installing components via brew..."
    brew install \
        bash-completion \
        git \
        grc \
        irssi \
        2> /dev/null

elif [ "$DIST" == "ubuntu" ]; then

    print_h1 "Installing components via apt-get..."
    apt-get --yes --force-yes --ignore-missing --no-install-recommends install \
        bash-completion \
        git \
        grc \
        irssi

fi

# install Oh My Zsh
if [ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
    print_h1 "Installing Oh My Zsh..."
    rm -rf ~/{.oh-my-zsh,.zcompdump-*,.zlogin,.zsh*}
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    #sudo chsh -s /bin/zsh $USER
fi

print_h1 "Configuring components..."

################################################################################
# Bash

print_h2 "Configure Bash"

# resources
cp -fv ~/etc/bash/.bash* ~
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
# Zsh

print_h2 "Configure Zsh"

# resources
cp -fv ~/etc/zsh/.zsh* ~

################################################################################
# Git

print_h2 "Configure Git"

# resources
cp -fv ~/etc/git/.git* ~

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

exit 0

################################################################################
# Vim                                                                          #
################################################################################

if which vim > /dev/null; then

    print_h2 "Configure Vim"

    # resources
    mkdir -p ~/.vim
    cp -Rf ./config/vim/{colors,plugin} ~/.vim
    cp -f ./config/vim/.vimrc ~
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
        git clone git://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
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
# Midnight Commander                                                           #
################################################################################

if which mc > /dev/null; then

    print_h2 "Configure Midnight Commander"

    # resources
    mkdir -p ~/.config/mc
    cp -f ./config/mc/* ~/.config/mc

fi

################################################################################
# Maven                                                                        #
################################################################################

if which mvn > /dev/null; then

    print_h2 "Configure Maven"

    # resources
    mkdir -p ~/.m2
    cp -f ./config/maven/settings*.xml ~/.m2

fi

################################################################################
# Irssi                                                                        #
################################################################################

if which irssi > /dev/null; then

    print_h2 "Configure Irssi"

    # resources
    mkdir -p ~/.irssi
    cp -f ./config/irssi/config ~/.irssi
    file_replace_str "real_name = \"\"" "real_name = \"$USER_NAME\"" ~/.irssi/config

fi

################################################################################

#if [ -z "$arg_common_only" ]; then

    # configure distribution specific components
    #print_h1 "Configuring distribution specific components..."
    #(. ./bin/config.$DIST.sh)
    #[ $? != 0 ] && exit 7

#fi


################################################################################

mkdir -p ~/projects
# install dotfiles repository
print_h1 "Installing dotfiles repository..."
if [ ! -d ~/projects/dotfiles ]; then
    git clone https://github.com/stefaniuk/dotfiles.git ~/projects/dotfiles
else
    (cd ~/projects/dotfiles; git pull)
fi
# install terminal commands repository
print_h1 "Installing terminal commands repository..."
if [ ! -d ~/projects/commands ]; then
    git clone https://github.com/stefaniuk/commands.git ~/projects/commands
else
    (cd ~/projects/commands; git pull)
fi
# install keyboard shortcuts repository
print_h1 "Installing keyboard shortcuts repository..."
if [ ! -d ~/projects/shortcuts ]; then
    git clone https://github.com/stefaniuk/shortcuts.git ~/projects/shortcuts
else
    (cd ~/projects/shortcuts; git pull)
fi
# install shell commons repository
print_h1 "Installing shell commons repository..."
if [ ! -d ~/projects/shell-commons ]; then
    git clone https://github.com/stefaniuk/shell-commons.git ~/projects/shell-commons
else
    (cd ~/projects/shell-commons; git pull)
fi
# install shell utils repository
print_h1 "Installing shell utils repository..."
if [ ! -d ~/projects/shell-utils ]; then
    git clone https://github.com/stefaniuk/shell-utils.git ~/projects/shell-utils
else
    (cd ~/projects/shell-utils; git pull)
fi
# install shell packages repository
print_h1 "Installing shell packages repository..."
if [ ! -d ~/projects/shell-packages ]; then
    git clone https://github.com/stefaniuk/shell-packages.git ~/projects/shell-packages
else
    (cd ~/projects/shell-packages; git pull)
fi

exit 0
