## Commands

    $ gpg2 --verbose --version
    $ gpg2 --list-keys
    $ gpg2 --list-secret-keys
    $ gpg2 --gen-key
    $ gpg2 --list-packets <file>
    $ pgpdump <file>

    $ gpg2 --import public.key
    $ gpg2 --allow-secret-key-import --import private.key
    $ gpg2 --edit-key 01E33140
        > key 1
        > delkey
        > save

    $ gpg2 --keyserver hkp://pool.sks-keyservers.net --send-keys 01E33140
    $ gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 01E33140

    $ gpg2 --delete-secret-key 01E33140
    $ gpg2 --delete-key 01E33140

#### signing files

    $ gpg2 -ab <file>
