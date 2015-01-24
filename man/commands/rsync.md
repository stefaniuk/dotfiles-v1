#### rsync

    rsync -rav --rsh='ssh -p22' --include=/ --exclude=.* \
        user@from-host:source user@to-host:destination
