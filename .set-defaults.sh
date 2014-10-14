#!/bin/bash

# SEE: https://gist.github.com/benfrain/7434600

exit 0

# make keyboard keys repeat properly when held down
defaults write -g ApplePressAndHoldEnabled -bool false

# no animation when new window is created
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# speed up dock animation
defaults write com.apple.dock autohide-delay -float 0.1
defaults write com.apple.dock autohide-time-modifier -float 0.5
# automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# speed up mission control animation
defaults write com.apple.dock expose-animation-duration -float 0.1

# speed up launchpad show and hide durations
defaults write com.apple.dock springboard-show-duration -float 0.1
defaults write com.apple.dock springboard-hide-duration -float 0.1

# don't automatically rearrange spaces
defaults write com.apple.dock mru-spaces -bool false

# don't show dashboard as a space
defaults write com.apple.dock dashboard-in-overlay -bool true

# disable dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false
# empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true
# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true
# Finder: display full POSIX path as window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# showing and hiding sheets, resizing preference windows, zooming windows
defaults write -g NSWindowResizeTime -float 0.001

# enable single application mode
defaults write com.apple.dock single-app -bool true

# copy text from quick look
defaults write com.apple.finder QLEnableTextSelection -bool true

# disable notification center
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist && killall NotificationCenter

# set language and text formats
#if you're in the US, replace EUR with USD, Centimeters with Inches, and true with false.
#defaults write NSGlobalDomain AppleLanguages -array “en” “nl”
#defaults write NSGlobalDomain AppleLocale -string “en_GB@currency=EUR”
#defaults write NSGlobalDomain AppleMeasurementUnits -string “Centimeters”
#defaults write NSGlobalDomain AppleMetricUnits -bool true

killall Dock
killall Finder

exit 0
