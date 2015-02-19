#### Vim

##### Quitting

    :q          exit as long as there have been no changes
    :q!         exit and ignore any changes
    :x          exit saving changes
    ZZ          exit saving changes

##### Navigation

    alt+click   move cursor using mouse
    h           move left
    j           move down
    k           move up
    l           move right
    w           move to next word
    W           move to next blank delimited word
    b           move to previous or the beginning of the word
    B           move to previous or the beginning of blank delimited word
    e           move to the end of the word
    E           move to the end of blank delimited word
    (           move a sentence back
    )           move a sentence forward
    {           move a paragraph back
    }           move a paragraph forward
    0           move to the beginning of the line
    $           move to the end of the line
    1G          move to the first line of the file
    G           move to the last line of the file
    nG          move to n-th line of the file
    H           move to top of screen
    M           move to middle of screen
    L           move to bottom of screen
    %           move to associated ( ), { }, [ ]

##### Inserting Text

    i           insert before cursor
    I           insert before line
    a           append after cursor
    A           append after line
    o           open a new line after current line
    O           open a new line before current line
    r           replace one character
    R           replace many characters

##### Deleting Text

Almost all deletion commands are performed by typing d followed by
a navigation command. For example, dw deletes a word.

    x           delete character to the right of cursor
    X           delete character to the left of cursor
    D           delete to the end of the line
    dd          delete current line

##### Copying Text

Like deletion, almost all yank commands are performed by typing y followed
by a motion. For example, y$ yanks to the end of the line.

    yy          yank the current line

##### Changing text
##### Putting text
##### Buffers
##### Markers
##### Search for strings
##### Replace
##### Regular Expressions
##### Counts
##### Ranges
##### Files
##### Other
