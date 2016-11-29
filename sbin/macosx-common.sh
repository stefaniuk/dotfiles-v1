#!/bin/bash

brew_update="brew update --verbose"
brew_upgrade="brew upgrade --verbose"
brew_tap="brew tap"
brew_install="brew install --verbose"
brew_cleanup="brew cleanup"
cask_install="brew cask install --appdir=$DIR/usr/applications --verbose"
cask_cleanup="brew cask cleanup"

if ! which brew > /dev/null; then
    softwareupdate --install -all
    xcode-select --install
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    $brew_tap homebrew/dupes
    $brew_tap homebrew/versions
    $brew_tap caskroom/versions
    $brew_install caskroom/cask/brew-cask
fi
