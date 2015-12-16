#!/bin/bash

################################################################################
# Bash

if should_config "bash"; then

    print_h2 "Configure Bash"

    # configuration
    sudo file_remove_str "\n$(brew --prefix)/bin/bash" /etc/shells --multiline
    sudo bash -c "echo $(brew --prefix)/bin/bash >> /private/etc/shells"
    sudo chsh -s $(brew --prefix)/bin/bash $USER

fi

################################################################################
# Zsh

if should_config "zsh"; then

    print_h2 "Configure Zsh"

    # configuration
    sudo file_remove_str "\n$(brew --prefix)/bin/zsh" /etc/shells --multiline
    sudo bash -c "echo $(brew --prefix)/bin/zsh >> /private/etc/shells"

fi

################################################################################
# Tmux

if should_config "tmux"; then

    print_h2 "Configure Tmux"

    # resources
    cat << EOF >> ~/.tmux.conf

# SEE http://evertpot.com/osx-tmux-vim-copy-paste-clipboard/
# copy-paste integration
set-option -g default-command "reattach-to-user-namespace -l bash"
# use vim keybindings in copy mode
setw -g mode-keys vi
# setup 'v' to begin selection as in Vim
bind-key -t vi-copy v begin-selection
bind-key -t vi-copy y copy-pipe "reattach-to-user-namespace pbcopy"
# update default binding of 'Enter' to also use copy-pipe
unbind -t vi-copy Enter
bind-key -t vi-copy Enter copy-pipe "reattach-to-user-namespace pbcopy"
# bind ']' to use pbpaste
bind ] run "reattach-to-user-namespace pbpaste | tmux load-buffer - && tmux paste-buffer"
EOF

fi

################################################################################
# iTerm

if [ -x ~/Applications/iTerm.app/Contents/MacOS/iTerm2 ]; then

    print_h2 "Configure iTerm"

    # configuration
    defaults import com.googlecode.iterm2 ./etc/iterm/com.googlecode.iterm2.plist

fi

################################################################################
# Sublime Text

if [ -x ~/Applications/Sublime\ Text.app/Contents/MacOS/Sublime\ Text ]; then

    print_h2 "Configure Sublime Text"

    # configuration
    mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/{Installed\ Packages,Packages/User}
    cp -f ./etc/sublime/* ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

    # package control
    if [ ! -f ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package ]; then
        curl \
            --url http://sublime.wbond.net/Package%20Control.sublime-package \
            --output ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package
    fi

fi

################################################################################
# Seil

if [ -x /Applications/Seil.app/Contents/Library/bin/seil ]; then

    print_h2 "Configure Seil"

    # configuration
    /Applications/Seil.app/Contents/Library/bin/seil set keycode_capslock 80
    /Applications/Seil.app/Contents/Library/bin/seil set enable_capslock 1
    print_h3 "Open 'System Preferences > Keyboard > Keyboard > Modifier Keys...' and"
    print_h3 "change 'Caps Lock Key' configuration to 'No Action' to reduce delay."

fi

################################################################################
# Karabiner

if [ -x /Applications/Karabiner.app/Contents/Library/bin/karabiner ]; then

    print_h2 "Configure Karabiner"

    # configuration
    cat << EOF > /Users/daniel/Library/Application\ Support/Karabiner/private.xml
<?xml version="1.0"?>
<root>
    <item>
        <name>Remap Caps Lock</name>
        <identifier>custom.remap_caps_lock</identifier>
        <autogen>
            --KeyToKey--
            KeyCode::F19,
            KeyCode::COMMAND_L, ModifierFlag::OPTION_L | ModifierFlag::SHIFT_L | ModifierFlag::CONTROL_L
        </autogen>
    </item>
    <item>
        <name>Use The Correct Shift Keys</name>
        <identifier>custom.correct_shift_keys</identifier>
        <autogen>--KeyToKey-- KeyCode::Q,           ModifierFlag::SHIFT_L, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::W,           ModifierFlag::SHIFT_L, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::E,           ModifierFlag::SHIFT_L, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::R,           ModifierFlag::SHIFT_L, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::T,           ModifierFlag::SHIFT_L, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::A,           ModifierFlag::SHIFT_L, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::S,           ModifierFlag::SHIFT_L, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::D,           ModifierFlag::SHIFT_L, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::F,           ModifierFlag::SHIFT_L, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::G,           ModifierFlag::SHIFT_L, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::Z,           ModifierFlag::SHIFT_L, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::X,           ModifierFlag::SHIFT_L, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::C,           ModifierFlag::SHIFT_L, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::V,           ModifierFlag::SHIFT_L, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::Y,           ModifierFlag::SHIFT_R, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::U,           ModifierFlag::SHIFT_R, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::I,           ModifierFlag::SHIFT_R, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::O,           ModifierFlag::SHIFT_R, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::P,           ModifierFlag::SHIFT_R, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::H,           ModifierFlag::SHIFT_R, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::J,           ModifierFlag::SHIFT_R, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::K,           ModifierFlag::SHIFT_R, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::L,           ModifierFlag::SHIFT_R, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::SEMICOLON,   ModifierFlag::SHIFT_R, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::N,           ModifierFlag::SHIFT_R, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::M,           ModifierFlag::SHIFT_R, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::COMMA,       ModifierFlag::SHIFT_R, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::DOT,         ModifierFlag::SHIFT_R, KeyCode::VK_NONE</autogen>
        <autogen>--KeyToKey-- KeyCode::QUOTE,       ModifierFlag::SHIFT_R, KeyCode::VK_NONE</autogen>
    </item>
    <item>
        <name>Map Shifts to Parentheses</name>
        <identifier>custom.shifts_to_parentheses</identifier>
        <autogen>--KeyOverlaidModifier-- KeyCode::SHIFT_R, ModifierFlag::SHIFT_R | ModifierFlag::NONE, KeyCode::SHIFT_R, KeyCode::KEY_0, ModifierFlag::SHIFT_L</autogen>
        <autogen>--KeyOverlaidModifier-- KeyCode::SHIFT_L, ModifierFlag::SHIFT_L | ModifierFlag::NONE, KeyCode::SHIFT_L, KeyCode::KEY_9, ModifierFlag::SHIFT_R</autogen>
        <autogen>--KeyToKey-- KeyCode::SHIFT_L, ModifierFlag::SHIFT_R, KeyCode::KEY_0, ModifierFlag::SHIFT_L, KeyCode::KEY_9, ModifierFlag::SHIFT_L</autogen>
        <autogen>--KeyToKey-- KeyCode::SHIFT_R, ModifierFlag::SHIFT_L, KeyCode::KEY_9, ModifierFlag::SHIFT_L, KeyCode::KEY_0, ModifierFlag::SHIFT_L</autogen>
        <autogen>--KeyToKey-- KeyCode::SPACE, ModifierFlag::SHIFT_R, KeyCode::KEY_0, ModifierFlag::SHIFT_L, KeyCode::SPACE</autogen>
    </item>
</root>
EOF
    /Applications/Karabiner.app/Contents/Library/bin/karabiner set repeat.initial_wait 333
    /Applications/Karabiner.app/Contents/Library/bin/karabiner set repeat.wait 33
    /Applications/Karabiner.app/Contents/Library/bin/karabiner enable custom.remap_caps_lock
    /Applications/Karabiner.app/Contents/Library/bin/karabiner enable custom.correct_shift_keys
    /Applications/Karabiner.app/Contents/Library/bin/karabiner disable custom.shifts_to_parentheses
    /Applications/Karabiner.app/Contents/Library/bin/karabiner reloadxml

fi

################################################################################
# defaults

print_h2 "Set defaults"

# set host details
if [ -n "$HOST_NAME" ]; then
    sudo scutil --set ComputerName $HOST_NAME
    sudo scutil --set HostName $HOST_NAME
    sudo scutil --set LocalHostName $HOST_NAME
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $HOST_NAME
fi

# set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelay 86400

# disable the sound effects on boot
sudo nvram SystemAudioVolume="%80"

# repeat keyboard keys when held down
defaults write -g ApplePressAndHoldEnabled -bool false

# no animation when new window is created
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# increase window resize speed for Cocoa applications
defaults write -g NSWindowResizeTime -float 0.001

# always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# speed up dock animation
defaults write com.apple.dock autohide-delay -float 0.1
defaults write com.apple.dock autohide-time-modifier -float 0.5

# automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# don't animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

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

# expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# enable single application mode
defaults write com.apple.dock single-app -bool true

# set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en" "pl"
defaults write NSGlobalDomain AppleLocale -string "en_GB"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

##########
# Finder #
##########

# disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# show path bar
defaults write com.apple.finder ShowPathbar -bool true

# allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# when performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# set default folder
defaults write com.apple.finder NewWindowTargetPath -string "file://~/"

# clear history
defaults write com.apple.finder FXRecentFolders -array

# show the ~/Library folder
chflags nohidden ~/Library

##########
# Safari #
##########

# set home page
defaults write com.apple.Safari HomePage -string "about:blank"

# prevent from opening 'safe' files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# show bookmarks by default
defaults write com.apple.Safari ShowFavoritesBar -bool true

# disable thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# remove search list
defaults write com.apple.Safari RecentWebSearches -array

# set up Safari for development
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

################################################################################

killall NotificationCenter > /dev/null 2>&1
killall Finder > /dev/null 2>&1
killall Dock > /dev/null 2>&1
killall SystemUIServer > /dev/null 2>&1

################################################################################

exit 0
