#!/bin/bash

#     $cask_install asepsis --appdir=/Applications
#     $cask_install caffeine --appdir=/Applications
#     $cask_install menumeters --appdir=/Applications
#     $cask_install android-file-transfer --appdir=/Applications

# $brew_install bash-completion
# $brew_install bc
# $brew_install binutils
# $brew_install curl
# $brew_install expect
# $brew_install git
# $brew_install openssl
# $brew_install pcre
# $brew_install perl
# $brew_install python3
# $brew_install rsync
# $brew_install unzip
# $brew_install wget
# $brew_install xz
# sudo easy_install Pygments

#     $brew_install ack
#     $brew_install grc
#     $brew_install htop
#     $brew_install lnav
#     $brew_install mc
#     $brew_install tcptraceroute
#     $brew_install tree
#     $brew_install vim
#     $brew_install zsh

#     $brew_install git-flow
#     $brew_install gpg2
#     $brew_install gtypist
#     $brew_install irssi
#     $brew_install lynx
#     $brew_install tmux reattach-to-user-namespace
#     $cask_install java

#     # developer tools
#     $cask_install iterm2-beta
#     $cask_install virtualbox
#     $cask_install virtualbox-extension-pack
#     $cask_install vagrant
#     $brew_install packer
#     $cask_install dockertoolbox
#     $cask_install github-desktop
#     $cask_install smartsynchronize
#     $cask_install filezilla
#     $cask_install sts
#     $cask_install phpstorm
#     $cask_install android-studio
#     $brew_install android-sdk
#     $brew_install android-ndk
#     $cask_install pgadmin3
#     $cask_install rdm
#     $cask_install apache-directory-studio
#     $cask_install xquartz wireshark
#     $cask_install gimp
#     # applications and utils
#     $cask_install xtrafinder
#     $cask_install firefox --appdir=/Applications
#     $cask_install firefoxdeveloperedition --appdir=/Applications
#     $cask_install flash
#     $cask_install adobe-reader
#     $cask_install xee22
#     $cask_install vox
#     $cask_install vlc

if should_install "dependencies"; then
    print_h2 "Dependencies"
fi

if should_install "system-bundle"; then
    print_h2 "System Bundle"
    $cask_install seil
    $cask_install karabiner
    $cask_install bettertouchtool
    $cask_install witch
    $cask_install moom
fi

if should_install "admin-bundle"; then
    print_h2 "Admin Bundle"
fi

if should_install "developer-bundle"; then
    print_h2 "Developer Bundle"
fi

if should_install "user-bundle"; then
    print_h2 "User Bundle"
    $cask_install dropbox
    $cask_install megasync
    $cask_install google-drive
    $cask_install boxcryptor
fi

should_install "chrome"     && (. $DIR/lib/chrome.sh $*)
should_install "smartgit"   && (. $DIR/lib/smartgit.sh $*)
should_install "subl"       && (. $DIR/lib/subl.sh $*)
