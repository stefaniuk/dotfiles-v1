#!/bin/bash

print_h1 "Configuring..."

################################################################################
# SSH

if should_config "ssh"; then

    print_h2 "SSH"

    mkdir -p $DIR/.ssh
    cp -f $DIR/etc/ssh/config $DIR/.ssh
    file_replace_str "github-user" "github-$GITHUB_ACCOUNT" $DIR/.ssh/config
    file_replace_str "bitbucket-user" "bitbucket-$BITBUCKET_ACCOUNT" $DIR/.ssh/config
    file_replace_str "gitlab-user" "gitlab-$GITLAB_ACCOUNT" $DIR/.ssh/config

fi

################################################################################
# Bash

if should_config "bash"; then

    print_h2 "Bash"

    [ -f $DIR/.profile ] && [ ! -f $DIR/.profile.old ] && mv $DIR/.profile $DIR/.profile.old
    [ -f $DIR/.bash_profile ] && [ ! -f $DIR/.bash_profile.old ] && mv $DIR/.bash_profile $DIR/.bash_profile.old

    cp -f $DIR/etc/bash/.bash* $DIR
    file_replace_str "USER_NAME=\"unknown\"" "USER_NAME=\"$USER_NAME\"" $DIR/.bash_exports
    file_replace_str "USER_EMAIL=\"unknown\"" "USER_EMAIL=\"$USER_EMAIL\"" $DIR/.bash_exports
    file_replace_str "GITHUB_ACCOUNT=\"unknown\"" "GITHUB_ACCOUNT=\"$GITHUB_ACCOUNT\"" $DIR/.bash_exports
    file_replace_str "GITLAB_ACCOUNT=\"unknown\"" "GITLAB_ACCOUNT=\"$GITLAB_ACCOUNT\"" $DIR/.bash_exports

fi

################################################################################
# Zsh

if should_config "zsh"; then

    print_h2 "Zsh"

    cp -f $DIR/etc/zsh/.zsh* $DIR

    if [ ! -f $DIR/.oh-my-zsh/oh-my-zsh.sh ]; then
        rm -rf $DIR/{.oh-my-zsh,.zcompdump-*,.zlogin,.zsh*}
        git clone \
            https://github.com/robbyrussell/oh-my-zsh.git \
            $DIR/.oh-my-zsh
        cp $DIR/.oh-my-zsh/templates/zshrc.zsh-template $DIR/.zshrc
    elif [ -d $DIR/.oh-my-zsh/.git ]; then
        (cd $DIR/.oh-my-zsh; git pull)
    fi

fi

################################################################################
# Git

if should_config "git"; then

    print_h2 "Git"

    cp -f $DIR/etc/git/.git* $DIR

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

    # diff-highlight
    if [ ! -f $DIR/bin/diff-highlight ]; then
        wget \
            https://raw.githubusercontent.com/git/git/master/contrib/diff-highlight/diff-highlight \
            -O $DIR/bin/diff-highlight
        chmod +x $DIR/bin/diff-highlight
    fi

fi

################################################################################
# Docker

if should_config "docker"; then

    print_h2 "Docker"

    sudo usermod -aG docker $USER

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

    print_h2 "Vagrant"

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

    print_h2 "Vim"

    cp -f $DIR/etc/vim/.vimrc $DIR
    mkdir -p $DIR/.vim/{autoload,bundle}
    #cp -Rf $DIR/etc/vim/plugin $DIR/.vim

    # vundle - plugin manager
    if [ ! -d $DIR/.vim/bundle/vundle ]; then
        git clone \
            https://github.com/gmarik/Vundle.vim.git \
            $DIR/.vim/bundle/vundle
    else
        (cd $DIR/.vim/bundle/vundle; git pull)
    fi
    # pathogen - plugin manager
    wget \
        https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim \
        -O $DIR/.vim/autoload/pathogen.vim

    # solarized
    if [ ! -d $DIR/.vim/bundle/solarized ]; then
        git clone \
            https://github.com/altercation/vim-colors-solarized.git \
            $DIR/.vim/bundle/solarized
    else
        (cd $DIR/.vim/bundle/solarized; git pull)
    fi
    # nerdtree
    #if [ ! -d $DIR/.vim/bundle/nerdtree ]; then
    #    git clone https://github.com/scrooloose/nerdtree.git $DIR/.vim/bundle/nerdtree
    #else
    #    (cd $DIR/.vim/bundle/nerdtree; git pull)
    #fi

fi

################################################################################
# Midnight Commander

if should_config "mc"; then

    print_h2 "Midnight Commander"

    mkdir -p $DIR/.config/mc
    [ -f /etc/mc/mc.keymap ] && cp -L /etc/mc/mc.keymap $DIR/.config/mc
    [ -f /usr/local/etc/mc/mc.keymap ] && cp -L /usr/local/etc/mc/mc.keymap $DIR/.config/mc
    [ -f /etc/mc/mc.menu ] && cp -L /etc/mc/mc.menu $DIR/.config/mc/menu
    [ -f /usr/local/etc/mc/mc.menu ] && cp -L /usr/local/etc/mc/mc.menu $DIR/.config/mc/menu
    cp -f $DIR/etc/mc/* $DIR/.config/mc

fi

################################################################################
# Tmux

if should_config "tmux"; then

    print_h2 "Tmux"

    cp -f $DIR/etc/tmux/.tmux.conf $DIR

    if [ ! -d $DIR/.tmux/plugins/tpm ]; then
        git clone \
            https://github.com/tmux-plugins/tpm \
            $DIR/.tmux/plugins/tpm
    else
        (cd $DIR/.tmux/plugins/tpm; git pull)
    fi

fi

################################################################################
# Sublime Text

if should_config "subl"; then

    print_h2 "Sublime Text"

    [ "$DIST" == "macosx" ] && dir=$DIR/Library/Application\ Support/Sublime\ Text\ 3
    [ "$DIST" == "ubuntu" ] && dir=$DIR/.config/sublime-text-3

    if [ -n "$dir" ]; then
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

        cp -f $DIR/etc/subl/*.sublime-settings "$dir/Packages/User"
    fi
fi

################################################################################
# Lynx

if should_config "lynx"; then

    print_h2 "Lynx"

    cp -f $DIR/etc/lynx/.lynx* $DIR

fi

################################################################################
# Irssi

if should_config "irssi"; then

    print_h2 "Irssi"

    mkdir -p $DIR/.irssi
    cp -f $DIR/etc/irssi/config $DIR/.irssi
    file_replace_str "real_name = \"\"" "real_name = \"$USER_NAME\"" $DIR/.irssi/config

fi

################################################################################
# Maven

if should_config "mvn"; then

    print_h2 "Maven"

    mkdir -p $DIR/.m2
    cp -f $DIR/etc/maven/settings*.xml $DIR/.m2

fi

################################################################################

(
    [ -f $DIR/sbin/$DIST-common.sh ] && . $DIR/sbin/$DIST-common.sh $*
    [ -f $DIR/sbin/$DIST-config.sh ] && . $DIR/sbin/$DIST-config.sh $*
)
