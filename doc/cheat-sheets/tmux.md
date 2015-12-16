## Commands

    tmux ls                         # list sessions
    tmux new -s <name>              # create new session
    tmux attach -t <name>           # attach to session
    tmux kill-session -t <name>     # kill session

## Shortcuts

`tmux` has been configured with `ctrl+a` prefix.

#### Sessions

    s               list sessions
    :new<CR>        new session
    $               name session
    d               detach from session

#### Windows

    c               create new window
    &               kill the current window
    n               go to the next window
    p               go to the previous window
    l               go to the previously selected window
    <number>        go to the specific window number
    w               list all windows
    .               move window
    ,               rename the current window

#### Panes

    %               horizontal split
    "               vertical split
    x               kill pane
    o               go to the next pane (cycle through all of them)
    arrow           go to other pane in that direction
    ;               go to the previously selected pane
    q               show pane numbers
    q <number>      go to the specific pane number

#### Misc

    :               prompt
    ?               list all key bindings
    ctrl+l ctrl+k   clear history (doesn't need the prefix)

###### Mac OS X

    fn+up           scroll up, press q to quit
    fn+down         scroll down, press q to quit