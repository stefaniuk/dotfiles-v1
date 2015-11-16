#!/bin/bash

if ! which brew > /dev/null; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap homebrew/dupes
    brew tap homebrew/versions
    brew tap homebrew/homebrew-php
    brew tap caskroom/versions
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
    brew install bzip2
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
    brew install zsh
fi

################################################################################
# install workstation tools

if [ -n "$arg_install_workstation_tools" ] && [ -z "$arg_install_server_tools" ]; then
    print_h2 "Install workstation tools"
    brew install ctags
    brew install ddclient
    brew install git-flow
    brew install gtypist
    brew install irssi
    brew install reattach-to-user-namespace
    brew cask install java
    # configuration and monitoring tools
    brew cask install seil --appdir=/Applications
    brew cask install karabiner --appdir=/Applications
    brew cask install bettertouchtool --appdir=/Applications
    brew cask install witch --appdir=/Applications
    brew cask install moom --appdir=/Applications
    brew cask install asepsis --appdir=/Applications
    brew cask install caffeine --appdir=/Applications
    brew cask install menumeters --appdir=/Applications
    brew cask install android-file-transfer --appdir=/Applications
    # developer tools
    brew cask install iterm2-beta
    brew cask install sublime-text3
    brew cask install virtualbox
    brew cask install virtualbox-extension-pack
    brew cask install vagrant
    brew cask install dockertoolbox
    brew cask install github-desktop
    brew cask install smartgit
    brew cask install smartsynchronize
    brew cask install filezilla
    brew cask install sts
    brew cask install phpstorm
    brew cask install android-studio
    brew install android-sdk
    brew install android-ndk
    brew cask install pgadmin3
    brew cask install rdm
    brew cask install apache-directory-studio
    brew cask install xquartz wireshark
    brew cask install gimp
    # applications and utils
    brew cask install xtrafinder
    brew cask install google-chrome --appdir=/Applications
    brew cask install firefox --appdir=/Applications
    brew cask install firefoxdeveloperedition --appdir=/Applications
    brew cask install flash
    brew cask install adobe-reader
    brew cask install dropbox --appdir=/Applications
    brew cask install megasync --appdir=/Applications
    brew cask install google-drive --appdir=/Applications
    brew cask install boxcryptor --appdir=/Applications
    brew cask install xee22
    brew cask install vox
    brew cask install vlc
fi

################################################################################

brew cleanup
brew cask cleanup

exit 0