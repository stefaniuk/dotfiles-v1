#!/bin/bash

function abspath() { pushd . > /dev/null; if [ -d "$1" ]; then cd "$1"; dirs -l +0; else cd "`dirname \"$1\"`"; cur_dir=`dirs -l +0`; if [ "$cur_dir" == "/" ]; then echo "$cur_dir`basename \"$1\"`"; else echo "$cur_dir/`basename \"$1\"`"; fi; fi; popd > /dev/null; }
function title() {
    tput setaf 1
    echo "$1"
    tput sgr 0
}
function info() {
    tput setaf 3
    echo "   $1"
    tput sgr 0
}

cd $(dirname $(abspath $0))

# iTerm
title "iTerm"
cp -f ./Library/Preferences/com.googlecode.iterm2.plist ~/Library/Preferences

# Vim
title "Vim"
mkdir -p ~/.vim
cp -Rf ./.vim/* ~/.vim
cp -f ./.vimrc ~
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
    (cd ~/.vim/bundle/Vundle.vim; git pull -v)
fi

# Midnight Commander
title "Midnight Commander"
mkdir -p ~/.config
cp -R ./.config/mc ~/.config

# Sublime Text
title "Sublime Text"
mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/{Installed\ Packages,Packages/User}
# install packages
curl --url http://sublime.wbond.net/Package%20Control.sublime-package --output ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package
if [ ! -d ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/Theme\ -\ Tomorrow ]; then
    git clone https://github.com/theymaybecoders/sublime-tomorrow-theme ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/Theme\ -\ Tomorrow
else
    (cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/Theme\ -\ Tomorrow; git pull -v)
fi
# copy settings
cp -f ./Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
cp -f ./Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default\ \(OSX\).sublime-keymap ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
cp -f ./Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
cp -f ./Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Blackboard\ \(SL\).tmTheme ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

# Seil
title "Seil"
/Applications/Seil.app/Contents/Library/bin/seil set keycode_capslock 80
info "Open 'System Preferences > Keyboard > Keyboard > Modifier Keys...'"
info "and change 'Caps Lock Key' configuration to 'No Action' to reduce delay"

# Karabiner
title "Karabiner"
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
/Applications/Karabiner.app/Contents/Library/bin/karabiner enable custom.shifts_to_parentheses
/Applications/Karabiner.app/Contents/Library/bin/karabiner reloadxml

# Git
git config --global user.name "Daniel Stefaniuk"
git config --global user.email "daniel.stefaniuk@gmail.com"
git config --global push.default simple

./.set-defaults.sh

exit 0
