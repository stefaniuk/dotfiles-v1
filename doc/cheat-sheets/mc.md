#### Midnight Commander

##### General

    ctrl+u      swap panels
    ctrl+o      show / hide (toggle) shell command line
    ctrl+x i    show / hide (toggle) other panel to info mode
    ctrl+x q    show / hide (toggle) other panel to view mode
    ctrl+r      refresh list
    ctrl+\      show directory hotlist
    left        change to parent directory
    right       change to selected directory (no action on files)
    ctrl+s      search
    ctrl+space  show directory size

##### Manipulation

    ctrl+x !    run a command to create panel listing
    ctrl+t      select / unselect item
    +           select by pattern
    -           unselect by pattern
    *           invert selection
    ctrl+x c    run chmod on selected item
    ctrl+x o    run chown on selected item
    ctrl+x v    run relative symbolic link on selected item
    ctrl+x s    run absolute symbolic link on selected item
    ctrl+x l    run hard link on selected item

##### F Keys

    f1          help
    f2          user menu
    f3          view file
    f4          edit file
    f5          copy to directory in other panel
    shift+f5    copy to current directory
    f6          move to directory in other panel
    shift+f6    rename
    f7          new directory
    f8          delete
    f9          menu bar
    f10         quit

##### Virtual File System

    F9 -> Left/Right -> Shell Link...
    F9 -> Left/Right -> SFTP link...

##### Customisation

    ~/.config/mc/ini        'panelizing' commands can be added
    .mc.menu                user menu can be customised for each directory
    ~/.config/mc/menu       user menu can be customised globally
    ~/.config/mc/mc.keymap  key mappings
