#!/bin/bash

################################################################################
# prerequisites

if ! which brew > /dev/null; then
    print_h2 "Install brew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install caskroom/cask/brew-cask
fi

################################################################################
# update

if [ -n "$arg_update_system" ]; then
    print_h2 "Update operating system"
    sudo softwareupdate --install -all
fi
if [ -n "$arg_update_packages" ]; then
    print_h2 "Update packages"
    brew tap homebrew/dupes
    brew tap caskroom/versions
    brew update
    brew upgrade
fi

################################################################################
# install basic tools

if [ -n "$arg_install" ]; then
    print_h2 "Install basic tools"
    brew install ack
    brew install bash
    brew install bash-completion
    brew install git
    brew install grc
    brew install htop
    brew install lynx
    brew install mc
    brew install pcre
    brew install tmux
    brew install tree
    brew install unzip
    brew install vim
    brew install wget
fi

################################################################################
# install build tools

if [ -n "$arg_install_build_tools" ]; then
    print_h2 "Install build tools"
    brew install binutils
    brew install bzip2
    brew install cmake
    brew install coreutils
    brew install gcc
    brew install gettext
    brew install icu4c
    brew install libiconv
    brew install makedepend
    brew install mcrypt
    brew install ncurses
    brew install openssl
    brew install zlib
fi

################################################################################
# install workstation tools

if [ -n "$arg_install_workstation_tools" ] && [ -z "$arg_install_server_tools" ]; then
    print_h2 "Install workstation tools"
    brew install git-flow
    brew install gtypist
    brew install irssi
    brew install zsh
    brew cask install boxcryptor
    brew cask install dockertoolbox
    brew cask install dropbox
    brew cask install filezilla
    brew cask install firefox
    brew cask install firefoxdeveloperedition
    brew cask install github-desktop
    brew cask install google-chrome
    brew cask install google-drive
    brew cask install iterm2-beta
    brew cask install java
    brew cask install megasync
    brew cask install phpstorm
    brew cask install smartgit
    brew cask install smartsynchronize
    brew cask install sublime-text3
    brew cask install vagrant
    brew cask install virtualbox
fi

################################################################################

brew cleanup
brew cask cleanup

exit 0
