## Commands

    $ find . -type f -exec dos2unix {} \; # convert line-endings
    $ find . -type f -print0 | xargs -0 perl -pi -e 's/ +$//' # trim whitespace
