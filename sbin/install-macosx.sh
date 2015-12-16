#!/bin/bash

brew_install="brew install"
cask_install="brew cask install"

################################################################################

if should_install "system"; then
    print_h2 "Install system tools"
    $cask_install seil --appdir=/Applications
    $cask_install karabiner --appdir=/Applications
    $cask_install bettertouchtool --appdir=/Applications
    $cask_install witch --appdir=/Applications
    $cask_install moom --appdir=/Applications
    $cask_install asepsis --appdir=/Applications
    $cask_install caffeine --appdir=/Applications
    $cask_install menumeters --appdir=/Applications
    $cask_install android-file-transfer --appdir=/Applications
    $brew_install ddclient
fi

print_h2 "Install dotfiles tools"
$brew_install bash-completion
$brew_install bc
$brew_install binutils
$brew_install curl
$brew_install expect
$brew_install git
$brew_install openssl
$brew_install pcre
$brew_install perl
$brew_install python3
$brew_install rsync
$brew_install unzip
$brew_install wget
$brew_install xz
sudo easy_install Pygments

if should_install "common"; then
    print_h2 "Install common tools"
    $brew_install ack
    $brew_install grc
    $brew_install htop
    $brew_install lnav
    $brew_install mc
    $brew_install tcptraceroute
    $brew_install tree
    $brew_install vim
    $brew_install zsh
fi

if should_install "workstation"; then
    print_h2 "Install workstation tools"
    $brew_install git-flow
    $brew_install gtypist
    $brew_install irssi
    $brew_install lynx
    $brew_install tmux reattach-to-user-namespace
    $cask_install java

    # developer tools
    $cask_install iterm2-beta
    $cask_install sublime-text3
    $cask_install virtualbox
    $cask_install virtualbox-extension-pack
    $cask_install vagrant
    $cask_install dockertoolbox
    $cask_install github-desktop
    $cask_install smartgit
    $cask_install smartsynchronize
    $cask_install filezilla
    $cask_install sts
    $cask_install phpstorm
    $cask_install android-studio
    $brew_install android-sdk
    $brew_install android-ndk
    $cask_install pgadmin3
    $cask_install rdm
    $cask_install apache-directory-studio
    $cask_install xquartz wireshark
    $cask_install gimp
    # applications and utils
    $cask_install xtrafinder
    $cask_install google-chrome --appdir=/Applications
    $cask_install firefox --appdir=/Applications
    $cask_install firefoxdeveloperedition --appdir=/Applications
    $cask_install flash
    $cask_install adobe-reader
    $cask_install dropbox --appdir=/Applications
    $cask_install megasync --appdir=/Applications
    $cask_install google-drive --appdir=/Applications
    $cask_install boxcryptor --appdir=/Applications
    $cask_install xee22
    $cask_install vox
    $cask_install vlc
fi

################################################################################

brew cleanup
brew cask cleanup

exit 0
